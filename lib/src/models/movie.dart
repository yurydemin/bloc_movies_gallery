import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final int id;
  final String title;
  final String tagline;
  final String description;
  final String poster;
  final bool isFavorite;

  Movie(this.id, this.title, this.tagline, this.description, this.poster,
      {this.isFavorite = false});

  @override
  List<Object> get props =>
      [isFavorite, id, title, tagline, description, poster];

  @override
  String toString() {
    return 'Movie { poster: $poster, description: $description, title: $title, id: $id }';
  }

  Movie copyWith(
      {int id,
      String title,
      String tagline,
      String description,
      String poster,
      bool isFavorite}) {
    return Movie(
      id ?? this.id,
      title ?? this.title,
      tagline ?? this.tagline,
      description ?? this.description,
      poster ?? this.poster,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Movie.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        tagline = json['tagline'],
        description = json['description'],
        poster = json['poster'],
        isFavorite = false;
}
