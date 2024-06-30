import 'package:dartz/dartz.dart';
import 'package:kinopoisk_app/features/movies/data/datasources/remote/movie_remote_data_source.dart';
import 'package:kinopoisk_app/features/movies/domain/entities/movie.dart';
import 'package:kinopoisk_app/features/movies/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, List<MovieEntity>>> getMovies(
      int page, int limit) async {
    try {
      final movies = await remoteDataSource.fetchMovies(page, limit);
      return Right(movies);
    } catch (e) {
      return Left('Failed to fetch movies: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, List<MovieEntity>>> searchMovies(String query,int page, int limit) async {
    try {
      final movies = await remoteDataSource.searchMovies(query, page, limit);
      return Right(movies);
    } catch (e) {
      return Left('Failed to search movies: ${e.toString()}');
    }
  }
}
