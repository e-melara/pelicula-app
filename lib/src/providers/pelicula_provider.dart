import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
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

  Future<List<Pelicula>> _getListPelicula(
      {String urlString, int page = 1}) async {
    final url = Uri.https(_url, urlString, {
      'api_key': _apiKey,
      'language': _language,
      'page': page.toString(),
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final peliculas = Peliculas.fromJsonList(decodedData['results']);
    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    final response =
        await this._getListPelicula(urlString: '3/movie/now_playing');
    return response;
  }

  Future<List<Pelicula>> getPopulares() async {
    if (this._isLoading) {
      return [];
    }

    this._isLoading = true;
    this._pagePopulares++;
    final response = await this._getListPelicula(
      urlString: '3/movie/popular',
      page: this._pagePopulares,
    );
    this._populares.addAll(response);
    ppSink(this._populares);
    this._isLoading = false;
    return response;
  }
}
