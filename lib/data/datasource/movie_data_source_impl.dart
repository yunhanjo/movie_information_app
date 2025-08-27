import 'package:dio/dio.dart';
import '../../env.dart';
import '../dto/movie_response_dto.dart';
import '../dto/movie_detail_dto.dart';
import 'movie_data_source.dart';

class MovieDataSourceImpl implements MovieDataSource {
  final Dio dio;
  MovieDataSourceImpl(this.dio);

  static const _base = 'https://api.themoviedb.org/3';
  Options get _auth =>
      Options(headers: {'Authorization': 'Bearer ${Env.apiKey}'});

  @override
  Future<MovieResponseDto?> fetchNowPlayingMovies() async {
    final r = await dio.get(
      '$_base/movie/now_playing?language=ko-KR&page=1',
      options: _auth,
    );
    return MovieResponseDto.fromJson(r.data);
  }

  @override
  Future<MovieResponseDto?> fetchPopularMovies() async {
    final r = await dio.get(
      '$_base/movie/popular?language=ko-KR&page=1',
      options: _auth,
    );
    return MovieResponseDto.fromJson(r.data);
  }

  @override
  Future<MovieResponseDto?> fetchTopRatedMovies() async {
    final r = await dio.get(
      '$_base/movie/top_rated?language=ko-KR&page=1',
      options: _auth,
    );
    return MovieResponseDto.fromJson(r.data);
  }

  @override
  Future<MovieResponseDto?> fetchUpcomingMovies() async {
    final r = await dio.get(
      '$_base/movie/upcoming?language=ko-KR&page=1',
      options: _auth,
    );
    return MovieResponseDto.fromJson(r.data);
  }

  @override
  Future<MovieDetailDto?> fetchMovieDetail(int id) async {
    final r = await dio.get('$_base/movie/$id?language=ko-KR', options: _auth);
    return MovieDetailDto.fromJson(r.data);
  }
}
