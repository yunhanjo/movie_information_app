import 'package:flutter/material.dart';
import '../../data/models/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback onTap;

  const MovieCard({super.key, required this.movie, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Hero(
        tag: "movie_${movie.id}",
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(movie.posterUrl, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
