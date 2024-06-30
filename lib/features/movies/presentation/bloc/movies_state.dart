part of 'movies_bloc.dart';

abstract class MoviesState extends Equatable {
  const MoviesState();  

  @override
  List<Object> get props => [];
}
class MoviesInitial extends MoviesState {}

class MoviesLoading extends MoviesState {}

class MovieLoadSuccess extends MoviesState {
  final List<MovieEntity> movies;

  const MovieLoadSuccess(this.movies);

  @override
  List<Object> get props => [movies];
}
class SearchMoviesSuccess extends MoviesState {
  final List<MovieEntity> movies;

  const SearchMoviesSuccess(this.movies);

  @override
  List<Object> get props => [movies];
}

class MoviesError extends MoviesState {
  final String message;

  const MoviesError(this.message);

  @override
  List<Object> get props => [message];
}