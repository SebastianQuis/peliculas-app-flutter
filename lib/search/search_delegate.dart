import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';
import 'package:provider/provider.dart';
import 'package:peliculas/providers/peliculas_provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  
  @override
  String get searchFieldLabel => 'Buscar..';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null), // null, para cancelar
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('BuildResults');
  }

  Widget _containerVacio(){
    return const Center(
      child: Icon(
        Icons.movie_creation_outlined,
        size: 130,
        color: Colors.black38,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _containerVacio();
    }

    // print('peticion http');

    final moviesProvider = Provider.of<PeliculasProvider>(context, listen: false);
    moviesProvider.getSugerenciaByQuery(query); // Llamar cada vez que la persona busque

    return StreamBuilder(
      stream: moviesProvider.sugerenciaStream,
      builder: ( _ , AsyncSnapshot<List<Movie>> snapshot) {
        
        if (!snapshot.hasData) return _containerVacio(); 

        final movies = snapshot.data!;  

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (_, int index) => _MovieItem(movies[index])
        );
      },
    );
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  const _MovieItem( this.movie);

  @override
  Widget build(BuildContext context) {

    movie.heroId = 'search-${movie.id}';

    return ListTile(
      leading: Hero(
        tag: movie.heroId!,
        child: FadeInImage(
          placeholder: const AssetImage('assets/no-image.jpg'), 
          image: NetworkImage( movie.fullPosterImg),
          width: 60,
          fit: BoxFit.contain,
        ),
      ),
      title: Text(movie.title),
      subtitle: Text('Popularidad de ${movie.popularity.toString()} '),
      onTap: () {
        Navigator.pushNamed(context, 'details', arguments: movie);
        // print(movie.title);
      } 
    );
  }
}