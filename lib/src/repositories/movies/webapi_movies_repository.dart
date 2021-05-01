import 'package:dio/dio.dart';
import 'package:bloc_movies_gallery/src/models/movie.dart';
import 'package:bloc_movies_gallery/src/repositories/movies/movies_repository.dart';

class WebApiMoviesRepository implements MoviesRepository {
  static const _url =
      "http://my-json-server.typicode.com/yurydemin/fake_json_server/movies/";
  Dio _dio = Dio();

  @override
  Future<List<Movie>> loadMovies() async {
    final response = await _dio.get(_url);
    return response.data.map<Movie>((movie) => Movie.fromJson(movie)).toList();
  }
}
