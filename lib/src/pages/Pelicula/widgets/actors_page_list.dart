import 'package:flutter/material.dart';
import 'package:peliculas/src/models/actor.dart';

class ActorsPageList extends StatelessWidget {
  final List<Actor> actors;

  const ActorsPageList({this.actors});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(
          initialPage: 1,
          viewportFraction: 0.3,
        ),
        itemCount: actors.length,
        itemBuilder: (BuildContext context, int i) {
          return ActorItem(item: actors.elementAt(i));
        },
      ),
    );
  }
}

class ActorItem extends StatelessWidget {
  final Actor item;
  const ActorItem({@required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              placeholder: AssetImage('assets/img/no-image.jpg'),
              image: NetworkImage(item.getFoto()),
              fit: BoxFit.cover,
              height: 150.0,
            ),
          ),
          Text(
            item.name,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
