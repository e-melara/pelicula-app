import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula.dart';
import 'package:peliculas/src/providers/pelicula_provider.dart';

class DataSearchDelegate extends SearchDelegate {
  final provider = new PeliculaProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }
    return FutureBuilder(
      future: provider.searchMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if (snapshot.hasData) {
          final items = snapshot.data;
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int i) {
              final item = items.elementAt(i);
              return ListTile(
                leading: FadeInImage(
                  width: 50.0,
                  fit: BoxFit.contain,
                  image: NetworkImage(item.getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                ),
                title: Text(item.title),
                subtitle: Text(item.originalTitle),
                onTap: () {
                  close(context, null);
                  item.uniqueId = '';
                  Navigator.pushNamed(context, "detalle", arguments: item);
                },
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
