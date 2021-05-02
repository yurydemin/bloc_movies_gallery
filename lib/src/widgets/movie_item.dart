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
                      bottom: -10,
                      right: 0,
                      child: Hero(
                        tag: '${movie.id}-icon',
                        child: IconButton(
                          icon: Icon(
                            Icons.star,
                            color:
                                movie.isFavorite ? Colors.yellow : Colors.white,
                          ),
                          onPressed: onFavoriteTap,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Hero(
                tag: '${movie.id}-title',
                child: Material(
                  child: Text(
                    movie.title,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Hero(
                  tag: '${movie.id}-tagline',
                  child: Material(
                    child: Text(
                      movie.tagline,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
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
