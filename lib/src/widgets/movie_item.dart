import 'package:bloc_movies_gallery/src/models/movie.dart';
import 'package:flutter/material.dart';

class MovieItem extends StatelessWidget {
  final GestureTapCallback onTap;
  final GestureTapCallback onFavoriteTap;
  final Movie movie;

  const MovieItem({
    Key key,
    @required this.onTap,
    @required this.onFavoriteTap,
    @required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    AspectRatio(
                      aspectRatio: 4 / 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                        child: Hero(
                          tag: movie.id,
                          child: Image.network(
                            movie.poster,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -20,
                      right: 20,
                      child: Hero(
                        tag: '${movie.id}-icon',
                        child: Material(
                          child: InkWell(
                            onTap: onFavoriteTap,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              color: movie.isFavorite
                                  ? Colors.yellow
                                  : Colors.white,
                              child: Icon(Icons.star),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Hero(
                  tag: '${movie.id}-description',
                  child: Material(
                    child: Text(
                      movie.description,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
