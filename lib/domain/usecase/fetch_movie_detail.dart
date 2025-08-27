// fetch_movie_detail.dart
import '../entity/movie_detail.dart';
import '../repository/movie_repository.dart';

class FetchMovieDetail {
  final MovieRepository repo;
  FetchMovieDetail(this.repo);
  Future<MovieDetail?> call(int id) => repo.fetchMovieDetail(id);
}
