// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kinopoisk_app/features/movies/domain/entities/movie.dart';
import 'package:kinopoisk_app/features/movies/domain/usecases/get_movies.dart';
import 'package:kinopoisk_app/features/movies/domain/usecases/search_movies.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetMovies getMovies;
  final SearchMovies searchMovies;

  MoviesBloc({required this.getMovies, required this.searchMovies})
      : super(MoviesInitial()) {
    on<FetchMovies>(_onFetchMovies);
    on<SearchMoviesEvent>(_onSearchMovies);
  }

  void _onFetchMovies(FetchMovies event, Emitter<MoviesState> emit) async {
    emit(MoviesLoading());
    final result = await getMovies(event.page, event.limit);
    // print(result);
    result.fold(
      (error) => emit(MoviesError(error)),
      (movies) => emit(MovieLoadSuccess(movies)),
    );
  }

  void _onSearchMovies(
      SearchMoviesEvent event, Emitter<MoviesState> emit) async {
    emit(MoviesLoading());
    final result = await searchMovies(event.query, event.page, event.limit);
    print('-----result: $result');
    result.fold(
      (error) => emit(MoviesError(error)),
      (movies) => emit(SearchMoviesSuccess(movies)),
    );
  }
}
