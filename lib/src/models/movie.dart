import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final String id;
  final String title;
  final String description;
  final String poster;
  final bool isFavorite;

  Movie(this.id, this.title, this.description, this.poster,
      {this.isFavorite = false});

  @override
  List<Object> get props => [isFavorite, id, title, description, poster];

  @override
  String toString() {
    return 'Movie { poster: $poster, description: $description, title: $title, id: $id }';
  }

  Movie copyWith(
      {String id,
      String title,
      String description,
      String poster,
      bool isFavorite}) {
    return Movie(
      id ?? this.id,
      title ?? this.title,
      description ?? this.description,
      poster ?? this.poster,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Movie.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        description = json['description'],
        poster = json['poster'],
        isFavorite = false;
}
