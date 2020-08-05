import 'package:flutter/material.dart';
import 'package:peliculas/src/widgets/movie_horizontal.dart';

import 'package:peliculas/src/widgets/swiper_card_list.dart';
import 'package:peliculas/src/providers/pelicula_provider.dart';

class HomePage extends StatelessWidget {
  final provider = new PeliculaProvider();

  @override
  Widget build(BuildContext context) {
    final swiperTarjetas = FutureBuilder(
      future: provider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return SwiperCardList(peliculas: snapshot.data);
        } else {
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );

    final footerCard = Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              "Populares",
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          FutureBuilder(
            future: provider.getPopulares(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontal(peliculas: snapshot.data);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Peliculas en cines'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            swiperTarjetas,
            footerCard,
          ],
        ),
      ),
    );
  }
}
