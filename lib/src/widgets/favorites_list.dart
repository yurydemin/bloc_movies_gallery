import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_movies_gallery/src/blocs/movies/movies_bloc.dart';
import 'package:bloc_movies_gallery/src/blocs/movies/movies_state.dart';
import 'package:bloc_movies_gallery/src/keys.dart';
import 'package:bloc_movies_gallery/src/screens/movie_details_screen.dart';
import 'package:bloc_movies_gallery/src/widgets/movie_item.dart';

class FavoritesList extends StatelessWidget {
  const FavoritesList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(
      builder: (context, state) {
        if (state is MoviesLoadInProgressState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MoviesLoadSuccessState) {
          final favorites = state.favorites;
          return ListView.builder(
            key: MoviesAppKeys.favoritesList,
            itemCount: favorites.length,
            itemBuilder: (BuildContext context, int index) {
              final favorite = favorites[index];
              return MovieItem(
                movie: favorite,
                onTap: () async {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) {
                      return MovieDetailsScreen(movieId: favorite.id);
                    }),
                  );
                },
                onFavoriteTap: () {},
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
