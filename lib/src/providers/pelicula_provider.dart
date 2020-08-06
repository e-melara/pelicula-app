import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/actor.dart';
import 'package:peliculas/src/models/pelicula.dart';

class PeliculaProvider {
  String _language = 'es_ES';
  String _url = 'api.themoviedb.org';
  String _apiKey = 'd5ef83e1e4bdb957f0e26adec67c7148';

  int _pagePopulares = 0;
  bool _isLoading = false;
  List<Pelicula> _populares = new List();
  final _ppStreamCtrl = StreamController<List<Pelicula>>.broadcast();

  Stream<List<Pelicula>> get ppStream => _ppStreamCtrl.stream;
  Function(List<Pelicula>) get ppSink => _ppStreamCtrl.sink.add;

  void disposeStreams() {
    _ppStreamCtrl.close();
  }

  _getListPelicula({
    String urlString,
    int page = 1,
    String query = '',
  }) async {
    final url = Uri.https(_url, urlString, {
      'api_key': _apiKey,
      'language': _language,
      'page': page.toString(),
      'query': query,
    });

    final resp = await http.get(url);
    return json.decode(resp.body);
  }

  Future<List<Pelicula>> searchMovie(String query) async {
    final decodedData = await this._getListPelicula(
      urlString: '3/search/movie',
      query: query,
    );
    final peliculas = Peliculas.fromJsonList(decodedData['results']);
    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    final decodedData = await this._getListPelicula(
      urlString: '3/movie/now_playing',
    );
    final peliculas = Peliculas.fromJsonList(decodedData['results']);
    return peliculas.items;
  }

  Future<bool> getPopulares() async {
    if (this._isLoading) {
      return false;
    }

    this._isLoading = true;
    this._pagePopulares++;

    final decodedData = await this._getListPelicula(
      urlString: '3/movie/popular',
      page: this._pagePopulares,
    );
    final peliculas = Peliculas.fromJsonList(decodedData['results']);
    this._populares.addAll(peliculas.items);
    ppSink(this._populares);
    this._isLoading = false;

    return true;
  }

  Future<List<Actor>> getCast(String peliculaId) async {
    final decodedData = await this._getListPelicula(
      urlString: '3/movie/$peliculaId/credits',
    );
    final cast = Cast.fromJsonList(decodedData['cast']);
    return cast.actores;
  }
}
