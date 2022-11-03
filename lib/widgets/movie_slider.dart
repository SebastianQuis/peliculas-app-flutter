import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';
import 'package:peliculas/providers/peliculas_provider.dart';

class MovieSlider extends StatefulWidget {
  final List<Movie> peliculas;
  final String? titulo;
  final Function onNextPage;

  MovieSlider({super.key, required this.peliculas, this.titulo, required this.onNextPage});

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // TODO: ejecutar codigo primera vez que widget se construyé
    scrollController.addListener(() {

      final posicionPixelScroll = scrollController.position.pixels; 
      final posicionPixelMaximoScroll = scrollController.position.maxScrollExtent; 
    
      if (posicionPixelScroll >= posicionPixelMaximoScroll - 500) {
        //TODO: Llamar provider
        widget.onNextPage();
      }

    });
  }

  @override
  void dispose() {
    // TODO: cuando el widget va ser destruido

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 290,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.titulo != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                widget.titulo!,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.peliculas.length,
              itemBuilder: (_, int index) => _MoviePoster( widget.peliculas[index], '${widget.titulo}-$index-${widget.peliculas[index]}' ))),
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  final Movie movie;
  final String heroId;

  const _MoviePoster( this.movie, this.heroId);

  @override
  Widget build(BuildContext context) {
    movie.heroId = heroId;

    return Container(
      width: 130,
      height: 190,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details',
                arguments: movie),
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(movie.fullPosterImg),
                  width: 130,
                  height: 190,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            movie.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
