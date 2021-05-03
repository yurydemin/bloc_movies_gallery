import 'package:equatable/equatable.dart';
import 'package:bloc_movies_gallery/src/models/movie.dart';

abstract class FilteredMoviesEvent extends Equatable {
  const FilteredMoviesEvent();
}

class FilterUpdated extends FilteredMoviesEvent {
  final String searchFilter;

  const FilterUpdated(this.searchFilter);

  @override
  List<Object> get props => [searchFilter];

  @override
  String toString() => 'FilterUpdated { search filter: $searchFilter }';
}

class MoviesUpdated extends FilteredMoviesEvent {
  final List<Movie> movies;

  const MoviesUpdated(this.movies);

  @override
  List<Object> get props => [movies];

  @override
  String toString() => 'MoviesUpdated { movies: $movies }';
}
