import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_movies_gallery/src/repositories/movies/movies_repository.dart';
import 'package:bloc_movies_gallery/src/blocs/movies/movies_event.dart';
import 'package:bloc_movies_gallery/src/blocs/movies/movies_state.dart';
import 'package:bloc_movies_gallery/src/models/movie.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final MoviesRepository moviesRepository;

  MoviesBloc({@required this.moviesRepository})
      : super(MoviesLoadInProgressState());

  @override
  Stream<MoviesState> mapEventToState(MoviesEvent event) async* {
    if (event is MoviesLoadingEvent) {
      yield* _mapMoviesLoadedToState();
    } else if (event is MovieToogleFavoriteEvent) {
      yield* _mapMovieToogleFavoriteToState(event);
    }
  }

  Stream<MoviesState> _mapMoviesLoadedToState() async* {
    try {
      final movies = await this.moviesRepository.loadMovies();
      yield MoviesLoadSuccessState(
        // TODO fromEntity
        // TODO check is favorite
        movies.map((movie) => movie).toList(),
      );
    } catch (_) {
      yield MoviesLoadFailureState();
    }
  }

  Stream<MoviesState> _mapMovieToogleFavoriteToState(
      MovieToogleFavoriteEvent event) async* {
    if (state is MoviesLoadSuccessState) {
      final favorites =
          List<Movie>.from((state as MoviesLoadSuccessState).favorites);
      // check movie already exists in favorites
      final int movieIndex =
          favorites.indexWhere((movie) => movie.id == event.movie.id);
      if (movieIndex == -1)
        favorites.add(event.movie);
      else
        favorites.removeAt(movieIndex);

      // update movie in movies list
      final List<Movie> updatedMovies =
          (state as MoviesLoadSuccessState).movies.map((movie) {
        return movie.id == event.movie.id ? event.movie : movie;
      }).toList();

      // update state
      yield MoviesLoadSuccessState(updatedMovies, favorites);
    }
  }
}
