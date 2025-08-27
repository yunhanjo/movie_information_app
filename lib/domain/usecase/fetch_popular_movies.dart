// fetch_popular_movies.dart
import '../entity/movie.dart';
import '../repository/movie_repository.dart';

class FetchPopularMovies {
  final MovieRepository repo;
  FetchPopularMovies(this.repo);
  Future<List<Movie>?> call() => repo.fetchPopularMovies();
}
