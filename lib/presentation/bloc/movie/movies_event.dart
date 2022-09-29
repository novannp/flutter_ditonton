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
