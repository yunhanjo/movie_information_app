// fetch_now_playing_movies.dart
import '../entity/movie.dart';
import '../repository/movie_repository.dart';

class FetchNowPlayingMovies {
  final MovieRepository repo;
  FetchNowPlayingMovies(this.repo);
  Future<List<Movie>?> call() => repo.fetchNowPlayingMovies();
}
