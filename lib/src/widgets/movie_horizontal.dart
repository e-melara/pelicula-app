import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula.dart';
import 'package:peliculas/src/widgets/movie_horizontal_item.dart';

class MovieHorizontal extends StatelessWidget {
  final Function siguiente;
  final List<Pelicula> peliculas;

  const MovieHorizontal({@required this.peliculas, @required this.siguiente});

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    final pageController = PageController(
      initialPage: 1,
      viewportFraction: 0.3,
    );

    pageController.addListener(() {
      if (pageController.position.pixels >=
          pageController.position.maxScrollExtent - 200) {
        print('siguiente');
        this.siguiente();
      }
    });

    return Container(
      height: _size.height * 0.2,
      child: PageView.builder(
        pageSnapping: false,
        controller: pageController,
        itemCount: this.peliculas.length,
        itemBuilder: (BuildContext context, int index) {
          final item = this.peliculas.elementAt(index);
          return MovieHorizontalItem(item: item);
        },
      ),
    );
  }
}
