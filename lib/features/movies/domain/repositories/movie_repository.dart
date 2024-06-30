import 'package:dartz/dartz.dart';
import 'package:kinopoisk_app/features/movies/domain/entities/movie.dart';

abstract class MovieRepository {
  Future<Either<String, List<MovieEntity>>> getMovies(int page, int limit);
  Future<Either<String, List<MovieEntity>>> searchMovies(
      String query, int page, int limit);
}
