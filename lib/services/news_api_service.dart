import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:news_aggregator/models/article.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NewsApiService {
  final apiKey = dotenv.env['API_KEY'];
  final baseUrl = dotenv.env['BASE_URL'];

  Future<List<Article>> searchNews({
    String query = 'example',
    String lang = 'en',
    String country = 'in',  // set country to India
    int maxResults = 10,
  }) async {
    final url = Uri.parse(
      '$baseUrl/search?q=$query&lang=$lang&country=$country&max=$maxResults&apikey=$apiKey',
    );

    final response = await http.get(url);

    print('Fetching query: $query');
    print('URL: $url');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List articlesJson = data['articles'] ?? [];

      return articlesJson.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch news: ${response.reasonPhrase}');
    }
  }
}