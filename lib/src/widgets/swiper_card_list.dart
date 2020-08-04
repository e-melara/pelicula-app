import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SwiperCardList extends StatelessWidget {
  final List<dynamic> peliculas;

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
          final src = "http://via.placeholder.com/350x150";
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.network(src, fit: BoxFit.fill),
          );
        },
      ),
    );
  }
}
