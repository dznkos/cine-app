import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:peliculas/models/pelicula_model.dart';



class PeliculasProvider {

  String _apikey = 'fa9c1760bcd55ee94b61ab8266f2a724';
  String _url = 'api.themoviedb.org';
  String _language = 'es_ES';

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key' : _apikey,
      'language' : _language
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final peliculas = Peliculas.fromJsonList( decodedData['results'] );

    //print(peliculas.items[2]);

    return peliculas.items;
  }

}
