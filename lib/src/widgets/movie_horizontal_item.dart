import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula.dart';

class MovieHorizontalItem extends StatelessWidget {
  final Pelicula item;

  const MovieHorizontalItem({@required this.item});

  @override
  Widget build(BuildContext context) {
    item.uniqueId = '${item.id}-card';

    final _card = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          Hero(
            tag: item.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(item.getPosterImg()),
                height: 160.0,
                fit: BoxFit.cover,
              ),
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

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "detalle", arguments: item);
      },
      child: _card,
    );
  }
}
