import 'package:equatable/equatable.dart';

class MovieEntity extends Equatable {
  final int id;
  final String name;
  final String alternativeName;
  final String description;
  final String shortDescription;
  final int year;
  final double kpRating;
  final double imdbRating;
  final String? posterUrl;
  final List<Genre> genres;

  const MovieEntity({
    required this.shortDescription,
    required this.id,
    required this.name,
    required this.alternativeName,
    required this.description,
    required this.year,
    required this.kpRating,
    required this.imdbRating,
    required this.genres,
    this.posterUrl,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        alternativeName,
        description,
        shortDescription,
        year,
        kpRating,
        imdbRating,
        posterUrl,
        genres
      ];
}

class Genre {
  final String name;

  Genre({required this.name});
}