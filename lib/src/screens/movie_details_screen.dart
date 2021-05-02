import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_movies_gallery/src/blocs/movies/movies_bloc.dart';
import 'package:bloc_movies_gallery/src/blocs/movies/movies_state.dart';
import 'package:bloc_movies_gallery/src/blocs/movies/movies_event.dart';
import 'package:gallery_saver/gallery_saver.dart';

class MovieDetailsScreen extends StatelessWidget {
  final int movieId;

  const MovieDetailsScreen({Key key, @required this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(builder: (context, state) {
      final movie = (state as MoviesLoadSuccessState)
          .movies
          .firstWhere((item) => item.id == movieId, orElse: () => null);
      return Scaffold(
        appBar: AppBar(
          title:
              Text(movie == null ? 'Movie details loading fail' : movie.title),
        ),
        body: movie == null
            ? Container()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: Stack(children: [
                        Hero(
                          tag: movie.id,
                          child: Image.network(
                            movie.poster,
                            //fit: BoxFit.fitWidth,
                          ),
                        ),
                        Positioned(
                          bottom: -10,
                          left: 0,
                          child: Hero(
                            tag: '${movie.id}-download',
                            child: IconButton(
                              icon: Icon(
                                Icons.file_download,
                                color: Colors.white,
                              ),
                              onPressed: () async {
                                GallerySaver.saveImage(movie.poster).then((bool
                                        success) =>
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Saved'))));
                              },
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -10,
                          right: 0,
                          child: Hero(
                            tag: '${movie.id}-icon',
                            child: IconButton(
                              icon: Icon(
                                Icons.star,
                                color: movie.isFavorite
                                    ? Colors.yellow
                                    : Colors.white,
                              ),
                              onPressed: () {
                                BlocProvider.of<MoviesBloc>(context).add(
                                  MovieToogleFavoriteEvent(movie.copyWith(
                                      isFavorite: !movie.isFavorite)),
                                );
                              },
                            ),
                          ),
                        ),
                      ]),
                    ),
                    Hero(
                      tag: '${movie.id}-title',
                      child: Material(
                        child: Text(
                          movie.title,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Hero(
                        tag: '${movie.id}-tagline',
                        child: Material(
                          child: Text(
                            movie.tagline,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Hero(
                        tag: '${movie.id}-description',
                        child: Material(
                          child: Text(
                            movie.description,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      );
    });
  }
}
