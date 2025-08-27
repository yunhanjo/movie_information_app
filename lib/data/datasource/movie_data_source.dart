import '../dto/movie_response_dto.dart';
import '../dto/movie_detail_dto.dart';

abstract interface class MovieDataSource {
  Future<MovieResponseDto?> fetchNowPlayingMovies();
  Future<MovieResponseDto?> fetchPopularMovies();
  Future<MovieResponseDto?> fetchTopRatedMovies();
  Future<MovieResponseDto?> fetchUpcomingMovies();
  Future<MovieDetailDto?> fetchMovieDetail(int id);
}
