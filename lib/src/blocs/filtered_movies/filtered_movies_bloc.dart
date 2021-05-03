import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_movies_gallery/src/blocs/filtered_movies/filtered_movies_event.dart';
import 'package:bloc_movies_gallery/src/blocs/filtered_movies/filtered_movies_state.dart';
import 'package:bloc_movies_gallery/src/blocs/movies/movies_bloc.dart';
import 'package:bloc_movies_gallery/src/blocs/movies/movies_state.dart';
import 'package:bloc_movies_gallery/src/models/movie.dart';

class FilteredMoviesBloc
    extends Bloc<FilteredMoviesEvent, FilteredMoviesState> {
  final MoviesBloc moviesBloc;
  StreamSubscription moviesSubscription;

  FilteredMoviesBloc({@required this.moviesBloc})
      : super(
          moviesBloc.state is MoviesLoadSuccessState
              ? FilteredMoviesLoadSuccessState(
                  (moviesBloc.state as MoviesLoadSuccessState).movies, '')
              : FilteredMoviesLoadInProgressState(),
        ) {
    moviesSubscription = moviesBloc.stream.listen((state) {
      if (state is MoviesLoadSuccessState) {
        add(MoviesUpdated((moviesBloc.state as MoviesLoadSuccessState).movies));
      }
    });
  }

  @override
  Stream<FilteredMoviesState> mapEventToState(
      FilteredMoviesEvent event) async* {
    if (event is FilterUpdated) {
      yield* _mapFilterUpdateToState(event);
    } else if (event is MoviesUpdated) {
      yield* _mapMoviesUpdateToState(event);
    }
  }

  Stream<FilteredMoviesState> _mapFilterUpdateToState(
      FilterUpdated event) async* {
    if (moviesBloc.state is MoviesLoadSuccessState) {
      yield FilteredMoviesLoadSuccessState(
        _mapMoviesToFilteredMovies(
          (moviesBloc.state as MoviesLoadSuccessState).movies,
          event.searchFilter,
        ),
        event.searchFilter,
      );
    }
  }

  Stream<FilteredMoviesState> _mapMoviesUpdateToState(
      MoviesUpdated event) async* {
    final searchFilter = state is FilteredMoviesLoadSuccessState
        ? (state as FilteredMoviesLoadSuccessState).searchFilter
        : '';
    yield FilteredMoviesLoadSuccessState(
      _mapMoviesToFilteredMovies(
        (moviesBloc.state as MoviesLoadSuccessState).movies,
        searchFilter,
      ),
      searchFilter,
    );
  }

  List<Movie> _mapMoviesToFilteredMovies(
      List<Movie> movies, String searchFilter) {
    return movies
        .where((movie) =>
            movie.title.toLowerCase().contains(searchFilter.toLowerCase()))
        .toList();
  }

  @override
  Future<void> close() {
    moviesSubscription.cancel();
    return super.close();
  }
}
