import 'package:kinopoisk_app/features/movies/domain/entities/movie.dart';

class MovieModel extends MovieEntity {
  const MovieModel({
    required super.id,
    required super.name,
    required super.alternativeName,
    required super.description,
    required super.shortDescription,
    required super.year,
    required super.kpRating,
    required super.imdbRating,
    super.posterUrl,
    required super.genres,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      alternativeName: json['alternativeName'] ?? '',
      description: json['description'] ?? '',
      shortDescription: json['shortDescription'] ?? '',
      year: json['year'] ?? 2024,
      kpRating: json['rating']['kp'].toDouble() ?? 0.0,
      imdbRating: json['rating']['imdb'].toDouble() ?? 0.0,
      posterUrl: json['poster'] != null ? json['poster']['url'] : '',
      genres: (json['genres'] as List)
          .map((genreJson) => Genre(name: genreJson['name']))
          .toList(),
    );
  }
}
