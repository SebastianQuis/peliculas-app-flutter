import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';


class CardSuperior extends StatelessWidget {
  //obtener la data e insertar en la interfaz
  final List<Movie> movies;

  const CardSuperior({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (movies.length == 0) {
      return Container(
        width: double.infinity,
        height: size.height * 0.6,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Container(
      width: double.infinity,
      height: size.height * 0.6,
      // color: Colors.grey,
      child: Swiper(
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.7,
        itemHeight: size.height * 0.5,
        itemBuilder: (_, int index) {

          final movie = movies[index];

          movie.heroId = 'superior-${movie.id}'; // Soluciona efecto envio
          
          return GestureDetector(
            // Detectar un clic y enviar a un nuevo screen
            onTap: () => Navigator.pushNamed(context, 'details',
                arguments: movie), //argumento = id
            child: Hero( // Efecto cuando pase a otro screen
              tag: movie.heroId!, // Tiene que ser único
              child: ClipRRect( // Darle border radius
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/loading.gif'),
                  image: NetworkImage(movie.fullPosterImg),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
