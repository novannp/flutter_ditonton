import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie/movie.dart';
import '../../../domain/usecases/get_top_rated_movies.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class NowPlayingMovies extends Bloc<MovieBlocEvent, MovieBlocState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  NowPlayingMovies(this._getNowPlayingMovies) : super(MoviesLoading()) {
    on<FetchNowPlayingMovies>((event, emit) async {
      emit(MoviesLoading());
      final result = await _getNowPlayingMovies.execute();
      result.fold((failure) {
        emit(MoviesHasError(failure.message));
      }, (movies) {
        emit(MoviesHasData(movies));
      });
    });
  }
}

class PopularMovies extends Bloc<MovieBlocEvent, MovieBlocState> {
  final GetPopularMovies _getPopularMovies;

  PopularMovies(this._getPopularMovies) : super(MoviesLoading()) {
    on<FetchPopularMovies>((event, emit) async {
      emit(MoviesLoading());
      final result = await _getPopularMovies.execute();
      result.fold((failure) {
        emit(MoviesHasError(failure.message));
      }, (movies) {
        emit(MoviesHasData(movies));
      });
    });
  }
}

class TopRatedMovies extends Bloc<MovieBlocEvent, MovieBlocState> {
  final GetTopRatedMovies _getTopRatedMovies;

  TopRatedMovies(this._getTopRatedMovies) : super(MoviesLoading()) {
    on<FetchTopRatedMovies>((event, emit) async {
      emit(MoviesLoading());
      final result = await _getTopRatedMovies.execute();
      result.fold((failure) {
        emit(MoviesHasError(failure.message));
      }, (movies) {
        emit(MoviesHasData(movies));
      });
    });
  }
}
