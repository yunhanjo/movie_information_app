class MovieDetail {
  final int budget;
  final List<String> genres;
  final int id;
  final List<String> productionCompanyLogos;
  final String overview;
  final double popularity;
  final DateTime? releaseDate;
  final int revenue;
  final int runtime;
  final String tagline;
  final String title;
  final double voteAverage;
  final int voteCount;

  const MovieDetail({
    required this.budget,
    required this.genres,
    required this.id,
    required this.productionCompanyLogos,
    required this.overview,
    required this.popularity,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.tagline,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
  });
}
