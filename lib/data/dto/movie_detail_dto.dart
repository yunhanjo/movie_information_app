class MovieDetailDto {
  final int id;
  final String? title;
  final String? overview;
  final String? tagline;
  final String? releaseDate;
  final int? runtime;
  final int? budget;
  final int? revenue;
  final double? popularity;
  final double? voteAverage;
  final int? voteCount;
  final List<GenreDto> genres;
  final List<ProductionCompanyDto> productionCompanies;
  final String? posterPath;
  final String? backdropPath;

  MovieDetailDto({
    required this.id,
    this.title,
    this.overview,
    this.tagline,
    this.releaseDate,
    this.runtime,
    this.budget,
    this.revenue,
    this.popularity,
    this.voteAverage,
    this.voteCount,
    required this.genres,
    required this.productionCompanies,
    this.posterPath,
    this.backdropPath,
  });

  factory MovieDetailDto.fromJson(Map<String, dynamic> json) {
    double? _toDouble(dynamic v) {
      if (v == null) return null;
      if (v is double) return v;
      if (v is int) return v.toDouble();
      return double.tryParse('$v');
    }

    return MovieDetailDto(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      tagline: json['tagline'],
      releaseDate: json['release_date'],
      runtime: json['runtime'],
      budget: json['budget'],
      revenue: json['revenue'],
      popularity: _toDouble(json['popularity']),
      voteAverage: _toDouble(json['vote_average']),
      voteCount: json['vote_count'],
      genres: (json['genres'] as List<dynamic>? ?? [])
          .map((e) => GenreDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      productionCompanies:
          (json['production_companies'] as List<dynamic>? ?? [])
              .map(
                (e) => ProductionCompanyDto.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
    );
  }
}

class GenreDto {
  final int id;
  final String name;
  GenreDto({required this.id, required this.name});
  factory GenreDto.fromJson(Map<String, dynamic> json) =>
      GenreDto(id: json['id'], name: json['name']);
}

class ProductionCompanyDto {
  final int id;
  final String? name;
  final String? logoPath;
  ProductionCompanyDto({required this.id, this.name, this.logoPath});
  factory ProductionCompanyDto.fromJson(Map<String, dynamic> json) =>
      ProductionCompanyDto(
        id: json['id'],
        name: json['name'],
        logoPath: json['logo_path'],
      );
}
