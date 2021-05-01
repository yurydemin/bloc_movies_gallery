import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_movies_gallery/src/blocs/movies/movies_bloc.dart';
import 'package:bloc_movies_gallery/src/blocs/movies/movies_event.dart';
import 'package:bloc_movies_gallery/src/blocs/movies/movies_state.dart';
import 'package:bloc_movies_gallery/src/keys.dart';
import 'package:bloc_movies_gallery/src/screens/movie_details_screen.dart';
import 'package:bloc_movies_gallery/src/widgets/movie_item.dart';

class MoviesList extends StatelessWidget {
  const MoviesList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(
      builder: (context, state) {
        if (state is MoviesLoadInProgressState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MoviesLoadSuccessState) {
          final movies = state.movies;
          return ListView.builder(
            key: MoviesAppKeys.moviesList,
            itemCount: movies.length,
            itemBuilder: (BuildContext context, int index) {
              final movie = movies[index];
              return MovieItem(
                movie: movie,
                onTap: () async {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) {
                      return MovieDetailsScreen(movieId: movie.id);
                    }),
                  );
                },
                onFavoriteTap: () {
                  BlocProvider.of<MoviesBloc>(context).add(
                    MovieToogleFavoriteEvent(
                        movie.copyWith(isFavorite: !movie.isFavorite)),
                  );
                },
              );
            },
          );
        } else {
          return Container(
            color: Colors.black,
          );
        }
      },
    );
  }
}
