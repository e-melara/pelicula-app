import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/pelicula.dart';

class SwiperCardList extends StatelessWidget {
  final List<Pelicula> peliculas;

  const SwiperCardList({Key key, this.peliculas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      width: double.infinity,
      child: Swiper(
        itemWidth: _size.width * 0.7,
        itemHeight: _size.height * 0.5,
        layout: SwiperLayout.STACK,
        itemCount: this.peliculas.length,
        itemBuilder: (BuildContext context, int index) {
          final src = this.peliculas[index].getPosterImg();
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              placeholder: AssetImage('assets/img/no-image.jpg'),
              image: NetworkImage(src),
            ),
          );
        },
      ),
    );
  }
}
