import 'package:bloc_movies_gallery/src/models/movie.dart';
import 'package:equatable/equatable.dart';

abstract class MoviesState extends Equatable {
  const MoviesState();

  @override
  List<Object> get props => [];
}

class MoviesLoadInProgressState extends MoviesState {}

class MoviesLoadSuccessState extends MoviesState {
  final List<Movie> movies;
  final List<Movie> favorites;

  const MoviesLoadSuccessState([
    this.movies = const [],
    this.favorites = const [],
  ]);

  @override
  List<Object> get props => [movies, favorites];

  @override
  String toString() =>
      'MoviesLoadSuccessState { movies: $movies, favorites: $favorites }';
}

class MoviesLoadFailureState extends MoviesState {}
