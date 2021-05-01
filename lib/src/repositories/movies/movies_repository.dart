import 'package:bloc_movies_gallery/src/models/movie.dart';

abstract class MoviesRepository {
  Future<List<Movie>> loadMovies();
}
