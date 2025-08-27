import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/datasource/movie_data_source.dart';
import '../data/datasource/movie_data_source_impl.dart';
import '../data/repository/movie_repository_impl.dart';
import '../domain/repository/movie_repository.dart';

import '../domain/usecase/fetch_now_playing_movies.dart';
import '../domain/usecase/fetch_popular_movies.dart';
import '../domain/usecase/fetch_top_rated_movies.dart';
import '../domain/usecase/fetch_upcoming_movies.dart';
import '../domain/usecase/fetch_movie_detail.dart';

// dio
final dioProvider = Provider<Dio>((ref) => Dio());

// datasource
final movieDataSourceProvider = Provider<MovieDataSource>(
  (ref) => MovieDataSourceImpl(ref.read(dioProvider)),
);

// repository
final movieRepositoryProvider = Provider<MovieRepository>(
  (ref) => MovieRepositoryImpl(ref.read(movieDataSourceProvider)),
);

// usecases
final nowPlayingUsecaseProvider = Provider(
  (ref) => FetchNowPlayingMovies(ref.read(movieRepositoryProvider)),
);
final popularUsecaseProvider = Provider(
  (ref) => FetchPopularMovies(ref.read(movieRepositoryProvider)),
);
final topRatedUsecaseProvider = Provider(
  (ref) => FetchTopRatedMovies(ref.read(movieRepositoryProvider)),
);
final upcomingUsecaseProvider = Provider(
  (ref) => FetchUpcomingMovies(ref.read(movieRepositoryProvider)),
);
final detailUsecaseProvider = Provider(
  (ref) => FetchMovieDetail(ref.read(movieRepositoryProvider)),
);
