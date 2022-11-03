import 'package:flutter/material.dart';
import 'package:peliculas/search/search_delegate.dart';
import 'package:peliculas/providers/peliculas_provider.dart';
import 'package:peliculas/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //traer instancia de peliculasProvider
    //listen: redibujate con alguna modificacion, es decir, cuando se llame el notifyListener
    final peliculasProvider = Provider.of<PeliculasProvider>(context);

    // print(peliculasProvider.obtenerPeliculas);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Películas'),
          actions: [
            IconButton(
              onPressed: () => showSearch( context: context, delegate: MovieSearchDelegate()),
              icon: const Icon(Icons.search_outlined),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CardSuperior(movies: peliculasProvider.listaPelicula), //tarjetas principales
              // SizedBox(height: 10,),
              MovieSlider(
                peliculas: peliculasProvider.listaPeliculaPopulares,
                titulo: 'Los más populares', 
                onNextPage: () => peliculasProvider.obtenerPeliculasPopulares(),
              ), //sliders de peliculas row
            ],
          ),
        ));
  }
}
