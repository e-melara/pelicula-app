import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;

  const MovieHorizontal({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _cards = this.peliculas.map((item) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(item.getPosterImg()),
                height: 160.0,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 5),
            Text(
              item.title,
              style: Theme.of(context).textTheme.caption,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      );
    }).toList();

    return Container(
      height: _size.height * 0.2,
      child: PageView(
        pageSnapping: false,
        controller: PageController(
          initialPage: 1,
          viewportFraction: 0.3,
        ),
        children: _cards,
      ),
    );
  }
}
