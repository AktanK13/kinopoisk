import 'package:dartz/dartz.dart';
import 'package:kinopoisk_app/features/movies/domain/entities/movie.dart';
import 'package:kinopoisk_app/features/movies/domain/repositories/movie_repository.dart';

class SearchMovies {
  final MovieRepository repository;

  SearchMovies({required this.repository});

  Future<Either<String, List<MovieEntity>>> call(String query,int page, int limit) {
    return repository.searchMovies(query,page,limit);
  }
}
