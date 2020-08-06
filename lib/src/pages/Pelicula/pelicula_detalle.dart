import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula.dart';
import 'package:peliculas/src/pages/Pelicula/widgets/actors_page_list.dart';
import 'package:peliculas/src/providers/pelicula_provider.dart';

class PeliculaDetalle extends StatelessWidget {
  PeliculaProvider provider = PeliculaProvider();

  @override
  Widget build(BuildContext context) {
    Pelicula item = ModalRoute.of(context).settings.arguments;

    final appBar = SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          item.title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.0,
          ),
          overflow: TextOverflow.fade,
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/img/loading.gif'),
          image: NetworkImage(item.getBackgroundImg()),
          // fadeInDuration: Duration(microseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );

    final poster = Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: item.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage(item.getPosterImg()),
                height: 150.0,
              ),
            ),
          ),
          SizedBox(width: 20.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  item.title,
                  style: Theme.of(context).textTheme.title,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  item.originalTitle,
                  style: Theme.of(context).textTheme.subhead,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.star_border),
                    Text(
                      item.voteAverage.toString(),
                      style: Theme.of(context).textTheme.subhead,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );

    final description = Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        item.overview,
        textAlign: TextAlign.justify,
      ),
    );

    final providerActors = FutureBuilder(
      future: provider.getCast(item.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return ActorsPageList(actors: snapshot.data);
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          appBar,
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 10.0),
              poster,
              description,
              description,
              description,
              description,
              providerActors,
            ]),
          ),
        ],
      ),
    );
  }
}
