import '../../domain/entity/movie.dart';
import '../../domain/entity/movie_detail.dart';
import '../../domain/repository/movie_repository.dart';
import '../datasource/movie_data_source.dart';
import '../dto/movie_response_dto.dart';
import '../dto/movie_detail_dto.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieDataSource ds;
  MovieRepositoryImpl(this.ds);

  List<Movie> _mapList(MovieResponseDto dto) => dto.results
      .map((m) => Movie(id: m.id, posterPath: m.posterPath ?? ''))
      .toList();

  MovieDetail _mapDetail(MovieDetailDto dto) => MovieDetail(
    budget: dto.budget ?? 0,
    genres: dto.genres.map((g) => g.name).toList(),
    id: dto.id,
    productionCompanyLogos: dto.productionCompanies
        .map((c) => c.logoPath ?? '')
        .toList(),
    overview: dto.overview ?? '',
    popularity: dto.popularity ?? 0,
    releaseDate: (dto.releaseDate == null || dto.releaseDate!.isEmpty)
        ? null
        : DateTime.tryParse(dto.releaseDate!),
    revenue: dto.revenue ?? 0,
    runtime: dto.runtime ?? 0,
    tagline: dto.tagline ?? '',
    title: dto.title ?? '',
    voteAverage: dto.voteAverage ?? 0,
    voteCount: dto.voteCount ?? 0,
  );

  @override
  Future<List<Movie>?> fetchNowPlayingMovies() async =>
      (await ds.fetchNowPlayingMovies())?.let(_mapList);

  @override
  Future<List<Movie>?> fetchPopularMovies() async =>
      (await ds.fetchPopularMovies())?.let(_mapList);

  @override
  Future<List<Movie>?> fetchTopRatedMovies() async =>
      (await ds.fetchTopRatedMovies())?.let(_mapList);

  @override
  Future<List<Movie>?> fetchUpcomingMovies() async =>
      (await ds.fetchUpcomingMovies())?.let(_mapList);

  @override
  Future<MovieDetail?> fetchMovieDetail(int id) async =>
      (await ds.fetchMovieDetail(id))?.let(_mapDetail);
}

// small helper
extension _Let<T> on T {
  R let<R>(R Function(T) f) => f(this);
}
