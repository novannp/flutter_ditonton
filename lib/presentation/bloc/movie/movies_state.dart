part of 'movies_bloc.dart';

abstract class MovieBlocState extends Equatable {
  const MovieBlocState();

  @override
  List<Object> get props => [];
}

class MoviesLoading extends MovieBlocState {}

class MoviesEmpty extends MovieBlocState {}

class MoviesHasData extends MovieBlocState {
  final List<Movie> movies;

  MoviesHasData(this.movies);

  @override
  List<Object> get props => [movies];
}

class MoviesHasError extends MovieBlocState {
  final String message;

  MoviesHasError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieDetailHasData extends MovieBlocState {
  final MovieDetail movie;

  MovieDetailHasData(this.movie);

  @override
  List<Object> get props => [movie];
}

class WatchlistMovieHasData extends MovieBlocState {
  final List<Movie> movies;

  WatchlistMovieHasData(this.movies);

  @override
  List<Object> get props => [movies];
}

class WatchlistMoviesMessage extends MovieBlocState {
  final String message;

  WatchlistMoviesMessage(this.message);
}

class LoadWatchlistData extends MovieBlocState {
  final bool status;

  LoadWatchlistData(this.status);

  @override
  List<Object> get props => [status];
}
