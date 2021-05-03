import 'package:equatable/equatable.dart';
import 'package:bloc_movies_gallery/src/models/movie.dart';

abstract class FilteredMoviesState extends Equatable {
  const FilteredMoviesState();

  @override
  List<Object> get props => [];
}

class FilteredMoviesLoadInProgressState extends FilteredMoviesState {}

class FilteredMoviesLoadSuccessState extends FilteredMoviesState {
  final List<Movie> filteredMovies;
  final String searchFilter;

  const FilteredMoviesLoadSuccessState(
    this.filteredMovies,
    this.searchFilter,
  );

  @override
  List<Object> get props => [filteredMovies, searchFilter];

  @override
  String toString() =>
      'FilteredMoviesLoadSuccessState { filtered movies: $filteredMovies, search filter: $searchFilter }';
}
