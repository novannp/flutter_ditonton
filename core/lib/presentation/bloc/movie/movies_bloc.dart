import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/movie/movie.dart';
import '../../../domain/entities/movie/movie_detail.dart';
import '../../../domain/usecases/movie_usecases/get_movie_detail.dart';
import '../../../domain/usecases/movie_usecases/get_movie_recommendations.dart';
import '../../../domain/usecases/movie_usecases/get_now_playing_movies.dart';
import '../../../domain/usecases/movie_usecases/get_popular_movies.dart';
import '../../../domain/usecases/movie_usecases/get_top_rated_movies.dart';
import '../../../domain/usecases/movie_usecases/get_watchlist_movies.dart';
import '../../../domain/usecases/movie_usecases/get_watchlist_status.dart';
import '../../../domain/usecases/movie_usecases/remove_watchlist.dart';
import '../../../domain/usecases/movie_usecases/save_watchlist.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class NowPlayingMoviesBloc extends Bloc<MovieBlocEvent, MovieBlocState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  NowPlayingMoviesBloc(this._getNowPlayingMovies) : super(MoviesLoading()) {
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

class PopularMoviesBloc extends Bloc<MovieBlocEvent, MovieBlocState> {
  final GetPopularMovies _getPopularMovies;

  PopularMoviesBloc(this._getPopularMovies) : super(MoviesLoading()) {
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

class TopRatedMoviesBloc extends Bloc<MovieBlocEvent, MovieBlocState> {
  final GetTopRatedMovies _getTopRatedMovies;

  TopRatedMoviesBloc(this._getTopRatedMovies) : super(MoviesLoading()) {
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

class DetailMovieBloc extends Bloc<MovieBlocEvent, MovieBlocState> {
  final GetMovieDetail _getMovieDetail;
  DetailMovieBloc(this._getMovieDetail) : super(MoviesLoading()) {
    on<FetchDetailMovie>((event, emit) async {
      final id = event.id;
      emit(MoviesLoading());
      final result = await _getMovieDetail.execute(id);
      result.fold((failure) {
        emit(MoviesHasError(failure.message));
      }, (data) {
        emit(MovieDetailHasData(data));
      });
    });
  }
}

class RecommendationMovieBloc extends Bloc<MovieBlocEvent, MovieBlocState> {
  final GetMovieRecommendations _getMovieRecommendations;
  RecommendationMovieBloc(this._getMovieRecommendations)
      : super(MoviesLoading()) {
    on<FetchMoviesRecommendation>((event, emit) async {
      final int id = event.id;
      emit(MoviesLoading());

      final result = await _getMovieRecommendations.execute(id);
      result.fold((l) {
        emit(MoviesHasError(l.message));
      }, (r) {
        emit(MoviesHasData(r));
      });
    });
  }
}

class WatchListBloc extends Bloc<MovieBlocEvent, MovieBlocState> {
  final GetWatchlistMovies _getWatchlistMovies;
  final GetWatchListStatus _getWatchListStatus;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  WatchListBloc(this._getWatchlistMovies, this._getWatchListStatus,
      this._saveWatchlist, this._removeWatchlist)
      : super(MoviesEmpty()) {
    on<FetchWatchlistMovies>(
      (event, emit) async {
        emit(MoviesLoading());

        final result = await _getWatchlistMovies.execute();
        result.fold((l) {
          emit(MoviesHasError(l.message));
        }, (r) {
          emit(WatchlistMovieHasData(r));
        });
      },
    );

    on<SaveWatchistMovies>((event, emit) async {
      final movie = event.movie;
      emit(MoviesLoading());
      final result = await _saveWatchlist.execute(movie);

      result.fold((l) => emit(MoviesHasError(l.message)),
          (r) => emit(WatchlistMoviesMessage(r)));
    });

    on<RemoveWatchlistMovies>((event, emit) async {
      final movie = event.movie;
      emit(MoviesLoading());
      final result = await _removeWatchlist.execute(movie);

      result.fold((l) => emit(MoviesHasError(l.message)),
          (r) => emit(WatchlistMoviesMessage(r)));
    });

    on<LoadWatchlistMovieStatus>((event, emit) async {
      final id = event.id;
      emit(MoviesLoading());
      final result = await _getWatchListStatus.execute(id);

      emit(LoadWatchlistData(result));
    });
  }
}
