import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:kinopoisk_app/features/movies/data/datasources/remote/movie_remote_data_source.dart';
import 'package:kinopoisk_app/features/movies/data/repositories/movie_repository_impl.dart';
import 'package:kinopoisk_app/features/movies/domain/usecases/get_movies.dart';
import 'package:kinopoisk_app/features/movies/domain/usecases/search_movies.dart';
import 'package:kinopoisk_app/features/movies/presentation/bloc/movies_bloc.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  // Регистрация клиента dio
  getIt.registerLazySingleton<Dio>(() => Dio());

  // Регистрация удаленного источника данных
  getIt
      .registerLazySingleton<MovieRemoteDataSource>(() => MovieRemoteDataSource(
            client: getIt<Dio>(),
          ));

  // Регистрация репозитория
  getIt.registerLazySingleton<MovieRepositoryImpl>(() =>
      MovieRepositoryImpl(remoteDataSource: getIt<MovieRemoteDataSource>()));

  // Регистрация Use Cases
  getIt.registerLazySingleton<GetMovies>(() => GetMovies(
        repository: getIt<MovieRepositoryImpl>(),
      ));

  getIt.registerLazySingleton<SearchMovies>(() => SearchMovies(
        repository: getIt<MovieRepositoryImpl>(),
      ));

  // Регистрация BLoC
  getIt.registerFactory<MoviesBloc>(() => MoviesBloc(
        getMovies: getIt<GetMovies>(),
        searchMovies: getIt<SearchMovies>(),
      ));
}
