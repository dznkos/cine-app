import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:peliculas/models/pelicula_model.dart';

class PeliculasProvider {

  String _apikey = 'fa9c1760bcd55ee94b61ab8266f2a724';
  String _url = 'api.themoviedb.org';
  String _language = 'es_ES';

  bool _cargandoPagina = false;

  int _popularesPage = 0;

  List<Pelicula> _populares = new List();

  final _popularesSteamController = new StreamController<List<Pelicula>>.broadcast();

  //Sink utilizado para agregar informacion al Stream
  Function(List<Pelicula>) get popularesSink => _popularesSteamController.sink.add;
  //Stream utilizado para obtener estado y informacion del Stream
  Stream<List<Pelicula>> get popularesStream => _popularesSteamController.stream;

  void disposeStreams() {
    _popularesSteamController?.close();
  }



  Future<List<Pelicula>> _procesoRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final peliculas = Peliculas.fromJsonList( decodedData['results'] );
    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key' : _apikey,
      'language' : _language
    });
    return await _procesoRespuesta(url);
  }

Future<List<Pelicula>> getPopulares() async {

    if ( _cargandoPagina ) return [];

    _cargandoPagina = true;
    print('Cargando Pagina');

    _popularesPage++;
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key' : _apikey,
      'language' : _language,
      'page' : _popularesPage.toString(),
    });
    final resp = await _procesoRespuesta(url);
    _populares.addAll(resp);

    popularesSink(_populares);

    _cargandoPagina = false;
    return resp;

  }

}
