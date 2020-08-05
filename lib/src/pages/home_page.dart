import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/pelicula_provider.dart';
import 'package:peliculas/src/widgets/swiper_card_list.dart';

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
          children: <Widget>[
            swiperTarjetas,
          ],
        ),
      ),
    );
  }
}
