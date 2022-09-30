import 'package:bloc/bloc.dart';
import 'package:tv_series/domain/entities/tv/tv_detail.dart';
import 'package:tv_series/domain/usecases/tv_usecases/get_on_the_air_tv.dart';
import 'package:tv_series/domain/usecases/tv_usecases/get_top_rated_tv.dart';
import 'package:tv_series/domain/usecases/tv_usecases/get_tv_recommendation.dart';
import 'package:tv_series/domain/usecases/tv_usecases/get_watchlist_tv.dart';
import 'package:tv_series/domain/usecases/tv_usecases/get_watchlist_tv_status.dart';
import 'package:tv_series/domain/usecases/tv_usecases/remove_tv_watchlist.dart';
import 'package:tv_series/domain/usecases/tv_usecases/save_tv_watchlist.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/tv/tv.dart';
import '../../../../domain/usecases/tv_usecases/get_popular_tv.dart';
import '../../../../domain/usecases/tv_usecases/get_tv_detail.dart';

part 'tv_event.dart';
part 'tv_state.dart';

class OnTheAirNowBloc extends Bloc<TvEvent, TvState> {
  final GetOnTheAirTv _getOnTheAirTv;
  OnTheAirNowBloc(this._getOnTheAirTv) : super(TvLoading()) {
    on<FetchOnTheAirNow>((event, emit) async {
      emit(TvLoading());
      final result = await _getOnTheAirTv.execute();
      result.fold((failure) {
        emit(TvHasError(failure.message));
      }, (tv) {
        emit(TvHasData(tv));
      });
    });
  }
}

class PopularTvBloc extends Bloc<TvEvent, TvState> {
  final GetPopularTv _getPopularTv;
  PopularTvBloc(this._getPopularTv) : super(TvLoading()) {
    on<FetchPopularTv>((event, emit) async {
      emit(TvLoading());
      final result = await _getPopularTv.execute();
      result.fold((failure) {
        emit(TvHasError(failure.message));
      }, (tv) {
        emit(TvHasData(tv));
      });
    });
  }
}

class TopRatedTvBloc extends Bloc<TvEvent, TvState> {
  final GetTopRatedTv _getTopRatedTv;
  TopRatedTvBloc(this._getTopRatedTv) : super(TvLoading()) {
    on<FetchTopRatedTv>((event, emit) async {
      emit(TvLoading());
      final result = await _getTopRatedTv.execute();
      result.fold((failure) {
        emit(TvHasError(failure.message));
      }, (tv) {
        emit(TvHasData(tv));
      });
    });
  }
}

class TvDetailBloc extends Bloc<TvEvent, TvState> {
  final GetTvDetail _getTvDetail;
  TvDetailBloc(this._getTvDetail) : super(TvLoading()) {
    on<FetchTvDetail>((event, emit) async {
      emit(TvLoading());
      final result = await _getTvDetail.execute(event.id);
      result.fold((failure) {
        emit(TvHasError(failure.message));
      }, (tv) {
        emit(TvDetailHasData(tv));
      });
    });
  }
}

class RecommendationTvBloc extends Bloc<TvEvent, TvState> {
  final GetTvRecomendation _getTvRecomendation;

  RecommendationTvBloc(this._getTvRecomendation) : super(TvEmpty()) {
    on<FetchTvRecommendation>((event, emit) async {
      emit(TvLoading());
      final result = await _getTvRecomendation.execute(event.id);
      result.fold((failure) {
        emit(TvHasError(failure.message));
      }, (tv) {
        emit(TvHasData(tv));
      });
    });
  }
}

class WatchlistTvBloc extends Bloc<TvEvent, TvState> {
  final GetWatchListTv _getWatchListTv;
  final GetWatchListTvStatus _getWatchListTvStatus;
  final SaveTvWatchlist _saveTvWatchlist;
  final RemoveTvWatchlist _removeTvWatchlist;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  WatchlistTvBloc(this._getWatchListTv, this._getWatchListTvStatus,
      this._saveTvWatchlist, this._removeTvWatchlist)
      : super(TvEmpty()) {
    on<FetchWatchListTv>((event, emit) async {
      emit(TvLoading());
      final result = await _getWatchListTv.execute();
      result.fold((failure) {
        emit(TvHasError(failure.message));
      }, (tv) {
        emit(WatchlistTvHasData(tv));
      });
    });

    on<SaveWatchlistTv>((event, emit) async {
      final tv = event.tv;
      emit(TvLoading());
      final result = await _saveTvWatchlist.execute(tv);

      result.fold((l) => emit(TvHasError(l.message)),
          (r) => emit(WatchlistTvMessage(r)));
    });

    on<RemoveWatchlistTv>((event, emit) async {
      final tv = event.tv;
      emit(TvLoading());
      final result = await _removeTvWatchlist.execute(tv);

      result.fold((l) => emit(TvHasError(l.message)),
          (r) => emit(WatchlistTvMessage(r)));
    });

    on<LoadWatchlistTvStatus>((event, emit) async {
      final id = event.id;
      emit(TvLoading());
      final result = await _getWatchListTvStatus.execute(id);
      emit(LoadWatchlistTvData(result));
    });
  }
}
