part of 'search_movies_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchEmpty extends SearchState {}

class SearchLoading extends SearchState {}

class SearchError extends SearchState {
  final String message;

  const SearchError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchMovieHasData extends SearchState {
  final List<Movie> result;

  const SearchMovieHasData(this.result);

  @override
  List<Object> get props => [result];
}

class SearchTvHasData extends SearchState {
  final List<Tv> result;

  const SearchTvHasData(this.result);

  @override
  List<Object> get props => [result];
}
