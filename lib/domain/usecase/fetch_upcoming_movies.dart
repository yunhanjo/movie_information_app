// fetch_upcoming_movies.dart
import '../entity/movie.dart';
import '../repository/movie_repository.dart';

class FetchUpcomingMovies {
  final MovieRepository repo;
  FetchUpcomingMovies(this.repo);
  Future<List<Movie>?> call() => repo.fetchUpcomingMovies();
}
