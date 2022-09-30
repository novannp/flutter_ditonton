part of 'tv_bloc.dart';

abstract class TvState extends Equatable {
  const TvState();

  @override
  List<Object> get props => [];
}

class TvEmpty extends TvState {}

class TvLoading extends TvState {}

class TvHasData extends TvState {
  final List<Tv> tvs;
  const TvHasData(this.tvs);

  @override
  List<Object> get props => [tvs];
}

class TvHasError extends TvState {
  final String message;
  const TvHasError(this.message);

  @override
  List<Object> get props => [message];
}

class TvDetailHasData extends TvState {
  final TvDetail tv;

  const TvDetailHasData(this.tv);

  @override
  List<Object> get props => [tv];
}

class WatchlistTvHasData extends TvState {
  final List<Tv> tvs;

  const WatchlistTvHasData(this.tvs);

  @override
  List<Object> get props => [tvs];
}

class WatchlistTvMessage extends TvState {
  final String message;

  const WatchlistTvMessage(this.message);
}

class LoadWatchlistTvData extends TvState {
  final bool status;

  const LoadWatchlistTvData(this.status);
}
