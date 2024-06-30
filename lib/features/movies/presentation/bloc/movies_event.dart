part of 'movies_bloc.dart';

abstract class MoviesEvent extends Equatable {
  const MoviesEvent();

  @override
  List<Object> get props => [];
}

class FetchMovies extends MoviesEvent {
  final int page;
  final int limit;

  const FetchMovies({required this.page, required this.limit});

  @override
  List<Object> get props => [page, limit];
}

class SearchMoviesEvent extends MoviesEvent {
  final String query;
  final int page;
  final int limit;

  const SearchMoviesEvent({
    required this.query,
    required this.page,
    required this.limit,
  });

  @override
  List<Object> get props => [query];
}
