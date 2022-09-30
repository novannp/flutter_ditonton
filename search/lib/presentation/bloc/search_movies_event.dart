part of 'search_movies_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class OnMovieQueryChanged extends SearchEvent {
  final String query;
  const OnMovieQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}

class OnTvQueryChanged extends SearchEvent {
  final String query;
  const OnTvQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}
