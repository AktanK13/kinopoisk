import 'package:dartz/dartz.dart';
import 'package:kinopoisk_app/features/movies/domain/entities/movie.dart';
import 'package:kinopoisk_app/features/movies/domain/repositories/movie_repository.dart';

class GetMovies {
  final MovieRepository repository;

  GetMovies({required this.repository});

  Future<Either<String, List<MovieEntity>>> call(int page, int limit) {
    return repository.getMovies(page, limit);
  }
}
