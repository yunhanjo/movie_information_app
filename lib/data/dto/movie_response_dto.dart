class MovieResponseDto {
  final int page;
  final List<MovieDto> results;
  final int? totalPages;
  final int? totalResults;

  MovieResponseDto({
    required this.page,
    required this.results,
    this.totalPages,
    this.totalResults,
  });

  factory MovieResponseDto.fromJson(Map<String, dynamic> json) {
    return MovieResponseDto(
      page: json['page'] ?? 1,
      results: (json['results'] as List<dynamic>)
          .map((e) => MovieDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
    );
  }
}

class MovieDto {
  final int id;
  final String? posterPath;
  final String? title;
  final String? releaseDate;
  final double? voteAverage;
  final int? voteCount;
  final double? popularity;

  MovieDto({
    required this.id,
    this.posterPath,
    this.title,
    this.releaseDate,
    this.voteAverage,
    this.voteCount,
    this.popularity,
  });

  factory MovieDto.fromJson(Map<String, dynamic> json) {
    double? _toDouble(dynamic v) {
      if (v == null) return null;
      if (v is double) return v;
      if (v is int) return v.toDouble();
      return double.tryParse('$v');
    }

    return MovieDto(
      id: json['id'],
      posterPath: json['poster_path'],
      title: json['title'] ?? json['name'],
      releaseDate: json['release_date'],
      voteAverage: _toDouble(json['vote_average']),
      voteCount: json['vote_count'],
      popularity: _toDouble(json['popularity']),
    );
  }
}
