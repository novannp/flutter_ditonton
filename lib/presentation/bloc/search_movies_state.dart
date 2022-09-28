part of 'search_movies_bloc.dart';

abstract class SearchMoviesState extends Equatable {
  const SearchMoviesState();

  @override
  List<Object> get props => [];
}

class SearchMovieEmpty extends SearchMoviesState {}

class SearchMovieLoading extends SearchMoviesState {}

class SearchMovieError extends SearchMoviesState {
  final String message;

  SearchMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchMovieHasData extends SearchMoviesState {
  final List<Movie> result;

  SearchMovieHasData(this.result);

  @override
  List<Object> get props => [result];
}
