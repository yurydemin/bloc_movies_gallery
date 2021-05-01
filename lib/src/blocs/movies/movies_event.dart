import 'package:bloc_movies_gallery/src/models/movie.dart';
import 'package:equatable/equatable.dart';

abstract class MoviesEvent extends Equatable {
  const MoviesEvent();

  @override
  List<Object> get props => [];
}

class MoviesLoadingEvent extends MoviesEvent {}

class MovieToogleFavoriteEvent extends MoviesEvent {
  final Movie movie;

  const MovieToogleFavoriteEvent(this.movie);

  @override
  List<Object> get props => [movie];

  @override
  String toString() => 'MovieToogleFavoriteEvent { movie: $movie }';
}
