import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';
import 'package:peliculas/theme/app_theme.dart';
import 'package:peliculas/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  //KEY: seleccionar este widget en el arbol de widgets

  @override
  Widget build(BuildContext context) {
    //TODO: cambiar por una instancia de movie

    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie; // como peli se instancia

    return Scaffold(
        body: CustomScrollView(
      // scrollview donde queda estatico el appbar
      slivers: [
        _AppBarPrincipal( movie ),
        SliverList(
          delegate: SliverChildListDelegate([
            _PosterYTitulo( movie),
            const SizedBox(
              height: 15,
            ),
            _DescripcionPelicula(movie),
            const SizedBox(
              height: 20,
            ),
            ListaCards( movie.id ),
          ]),
        )
      ],
    ));
  }
}

class _AppBarPrincipal extends StatelessWidget {
  final Movie movie;
  const _AppBarPrincipal( this.movie);
  
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppTheme.primary,
      expandedHeight: 250,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black26, //fondo con transparencia
          padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
          child: Text(
            movie.title,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18),
          ),
        ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage(movie.fullBackdropPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterYTitulo extends StatelessWidget {
  final Movie movie;

  const _PosterYTitulo(this.movie);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final TextTheme textTheme =
        Theme.of(context).textTheme; //solo dentro de estyle

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        //fila 2
        children: [
          Hero(
            tag: movie.heroId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullPosterImg),
                height: 150,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          ConstrainedBox(
            constraints: BoxConstraints( maxWidth: size.width - 170),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text( movie.title, style: textTheme.headline5, overflow: TextOverflow.ellipsis, maxLines: 2),
                Text( movie.originalTitle, style: textTheme.subtitle1, overflow: TextOverflow.ellipsis ),
                Row(
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 50)),
                    const Icon( Icons.star_outlined, size: 25, color: Colors.yellow, ),
                    const SizedBox( width: 5,),
                    Text( '${movie.voteAverage}', style: textTheme.caption, )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _DescripcionPelicula extends StatelessWidget {
  final Movie movie;

  const _DescripcionPelicula(this.movie);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify, //estilo de parrafo
        style: textTheme.subtitle1,
      ),
    );
  }
}
