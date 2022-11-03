import 'package:flutter/cupertino.dart';
import 'package:peliculas/models/models.dart';
import 'package:peliculas/providers/peliculas_provider.dart';
import 'package:provider/provider.dart';

class ListaCards extends StatelessWidget {
  final int movieId;

  ListaCards(this.movieId);

  @override
  Widget build(BuildContext context) {
    //listen false porque no se necesita redibujar

    final movieProvider = Provider.of<PeliculasProvider>(context, listen: false);

    return FutureBuilder(
      future: movieProvider.getMovieCast(movieId),
      builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            constraints: const BoxConstraints(maxWidth: 150),
            height: 190,
            child: const CupertinoActivityIndicator(),
          );
        }

        final List<Cast> cast = snapshot.data!;

        return Container(
          margin: const EdgeInsets.only(bottom: 30),
          width: double.infinity,
          height: 190,
          // color: Colors.red,
          child: ListView.builder(
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, int index) => _UnCard(cast[index])
          ),
        );
      },
    );
  }
}


class _UnCard extends StatelessWidget {
  final Cast actor;

  const _UnCard(this.actor);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 100,
      // color: Colors.red,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage(actor.fullProfilePath),
              width: 110,
              height: 140,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
