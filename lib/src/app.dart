import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_movies_gallery/src/blocs/movies/movies_bloc.dart';
import 'package:bloc_movies_gallery/src/blocs/movies/movies_event.dart';
import 'package:bloc_movies_gallery/src/routes.dart';
import 'package:bloc_movies_gallery/src/screens/home_screen.dart';
import 'package:bloc_movies_gallery/src/repositories/movies/webapi_movies_repository.dart';
import 'package:bloc_movies_gallery/src/blocs/tab/tab_bloc.dart';
import 'package:bloc_movies_gallery/src/blocs/filtered_movies/filtered_movies_bloc.dart';

class MoviesApp extends StatelessWidget {
  const MoviesApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return MoviesBloc(moviesRepository: WebApiMoviesRepository())
          ..add(MoviesLoadingEvent());
      },
      child: MaterialApp(
        title: 'Movies gallery',
        routes: {
          MoviesAppRoutes.home: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider<TabBloc>(
                  create: (context) => TabBloc(),
                ),
                BlocProvider<FilteredMoviesBloc>(
                  create: (context) => FilteredMoviesBloc(
                    moviesBloc: BlocProvider.of<MoviesBloc>(context),
                  ),
                ),
              ],
              child: HomeScreen(),
            );
          },
        },
      ),
    );
  }
}
