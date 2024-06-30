import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kinopoisk_app/core/constants/constants.dart';
import 'package:kinopoisk_app/features/movies/data/models/movie_model.dart';

class MovieRemoteDataSource {
  final Dio client;
  MovieRemoteDataSource({required this.client});
  final Options options = Options(
    headers: {
      'X-API-KEY': dotenv.env['X_API_KEY'],
    },
  );

  Future<List<MovieModel>> fetchMovies(int page, int limit) async {
    try {
      final response = await client.get(AppConsts.baseUrl,
          queryParameters: {
            'page': page,
            'limit': limit,
            'networks.items.name': AppConsts.netflixQuery,
          },
          options: options);

      if (response.statusCode == 200) {
        // print(response);
        final List<MovieModel> movies = parseMovies(response.data);
        return movies;
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (e) {
      throw Exception('Failed to fetch movies: $e');
    }
  }

  Future<List<MovieModel>> searchMovies(
      String query, int page, int limit) async {
    // print('---------searchMovies query: $query');
    try {
      final response = await client.get(AppConsts.searchUrl,
          queryParameters: {
            'page': page,
            'limit': limit,
            'query': query,
          },
          options: options);
      if (response.statusCode == 200) {
        final List<MovieModel> movies = parseMovies(response.data);
        // print('-----------parseMovies: $movies');
        // print(movies);
        return movies;
      } else {
        throw Exception('Failed to search movies (${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Failed to search movies: $e');
    }
  }

  List<MovieModel> parseMovies(dynamic responseBody) {
    final List<dynamic> jsonList = responseBody['docs'];
    return jsonList.map((json) => MovieModel.fromJson(json)).toList();
  }
}
