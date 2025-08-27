import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String get apiKey => dotenv.env['TMDB_API_KEY'] ?? '';

  static const String imageBase = 'https://image.tmdb.org/t/p';

  static String posterUrl(String? path, {int width = 185}) {
    if (path == null || path.isEmpty) return '';
    return '$imageBase/w$width$path';
  }
}
