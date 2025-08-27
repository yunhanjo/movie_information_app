// fetch_top_rated_movies.dart
import '../entity/movie.dart';
import '../repository/movie_repository.dart';

class FetchTopRatedMovies {
  final MovieRepository repo;
  FetchTopRatedMovies(this.repo);
  Future<List<Movie>?> call() => repo.fetchTopRatedMovies();
}
