import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/helpers/debouncer.dart';
import 'package:peliculas/models/models.dart';

class PeliculasProvider extends ChangeNotifier {
  final String _apiKey = 'f2715dcbc6e9e0a110a6d11008295f50';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-ES';

  int _popularPage = 0;

  List<Movie> listaPelicula = []; //Listado de peliculas que vienen
  List<Movie> listaPeliculaPopulares =
      []; //Listado de peliculas populares que vienen

  Map<int, List<Cast>> movieCast = {};

  final debouncer = Debouncer(
    duration: Duration(milliseconds: 500),
  );

  final StreamController<List<Movie>> _sugerenciaStreamController =
      StreamController.broadcast();
  Stream<List<Movie>> get sugerenciaStream =>
      _sugerenciaStreamController.stream;

  PeliculasProvider() {
    // print('Provider inicializando');
    obtenerPeliculas();
    obtenerPeliculasPopulares();
  }

  Future<String> getData(String segmento, [int page = 1]) async {
    //por defecto captura pagina 1
    final url = Uri.https(_baseUrl, segmento,
        {'api_key': _apiKey, 'language': _language, 'page': '$page'});

    final response = await http.get(url);

    return response.body;
  }

  obtenerPeliculas() async {
    final jasonData = await getData('3/movie/now_playing');
    //solo acepta la primera pagina de donde viene la data.
    final dataResponse = NowPlayingResponse.fromJson(
        jasonData); //decodificando y obteniendo el json

    listaPelicula = dataResponse.results;
    // final Map<String, dynamic> decodedData = json.decode(response.body);
    // print(dataResponse.results[1].title); //results es una lista de movies
    notifyListeners(); //traer todos los cambios
  }

  obtenerPeliculasPopulares() async {
    _popularPage++; //obtener todas las paginas de populares del json
    final jasonData = await getData('3/movie/popular', _popularPage);
    final popularResponse = PopularResponse.fromJson(
        jasonData); //decodificando y obteniendo el json

    listaPeliculaPopulares = [
      ...listaPeliculaPopulares,
      ...popularResponse.results
    ];

    // print(listaPeliculaPopulares);

    notifyListeners(); //redibujar los necesarios
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (movieCast.containsKey(movieId)) return movieCast[movieId]!;

    print('pidiendo info al servidor');
    final jsonData = await getData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);

    movieCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;
  }

  Future<List<Movie>> obtenerBusqueda(String query) async {
    final url = Uri.https(_baseUrl, '3/search/movie', {
      'api_key': _apiKey,
      'language': _language,
      'query': query,
    });

    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body);

    return searchResponse.results;
  }

  void getSugerenciaByQuery(String query) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      // print('tenemos valor a buscar: $value');
      final resultado = await obtenerBusqueda(value);
      _sugerenciaStreamController.add(resultado);
    };

    final timer = Timer.periodic(Duration(milliseconds: 500), (_) {
      debouncer.value = query;
    });

    Future.delayed(Duration(milliseconds: 501)).then((_) => timer.cancel());
  }
}
