part of 'movies_bloc.dart';

abstract class MovieBlocEvent extends Equatable {
  const MovieBlocEvent();

  @override
  List<Object> get props => [];
}

class FetchNowPlayingMovies extends MovieBlocEvent {}

class FetchPopularMovies extends MovieBlocEvent {}

class FetchTopRatedMovies extends MovieBlocEvent {}

class FetchDetailMovie extends MovieBlocEvent {
  final int id;
  const FetchDetailMovie(this.id);

  @override
  List<Object> get props => [id];
}

class FetchMoviesRecommendation extends MovieBlocEvent {
  final int id;
  const FetchMoviesRecommendation(this.id);

  @override
  List<Object> get props => [id];
}

class FetchWatchlistMovies extends MovieBlocEvent {}

class SaveWatchistMovies extends MovieBlocEvent {
  final MovieDetail movie;

  const SaveWatchistMovies(this.movie);
  @override
  List<Object> get props => [movie];
}

class RemoveWatchlistMovies extends MovieBlocEvent {
  final MovieDetail movie;

  const RemoveWatchlistMovies(this.movie);
  @override
  List<Object> get props => [movie];
}

class LoadWatchlistMovieStatus extends MovieBlocEvent {
  final int id;

  const LoadWatchlistMovieStatus(this.id);

  @override
  List<Object> get props => [id];
}
