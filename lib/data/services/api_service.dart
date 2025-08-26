import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

class ApiService {
  static const String _baseUrl = "https://api.themoviedb.org/3";
  static const String _apiKey = "YOUR_TMDB_API_KEY"; // 🔑 여기에 API Key 입력

  Future<List<Movie>> fetchMovies(String category) async {
    final url = Uri.parse(
      "$_baseUrl/movie/$category?api_key=$_apiKey&language=ko-KR&page=1",
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results'];
      return results.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception("영화 데이터를 불러오지 못했습니다");
    }
  }
}
