import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/pelicula.dart';

class PeliculaProvider {
  String _language = 'es_ES';
  String _url = 'api.themoviedb.org';
  String _apiKey = 'd5ef83e1e4bdb957f0e26adec67c7148';

  Future<List<Pelicula>> _getListPelicula(String urlString) async {
    final url = Uri.https(_url, urlString, {
      'api_key': _apiKey,
      'language': _language,
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final peliculas = Peliculas.fromJsonList(decodedData['results']);
    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    return await this._getListPelicula('3/movie/now_playing');
  }

  Future<List<Pelicula>> getPopulares() async {
    return this._getListPelicula('3/movie/popular');
  }
}
