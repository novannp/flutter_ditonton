import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendation.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_status.dart';
import 'package:ditonton/domain/usecases/remove_tv_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tv_watchlist.dart';
import 'package:flutter/material.dart';

import '../../common/state_enum.dart';
import '../../domain/entities/tv.dart';

class TvDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvDetail getTvDetail;
  final GetTvRecomendation getTvRecomendation;
  final SaveTvWatchlist saveTvWatchlist;
  final GetWatchListTvStatus getWatchListTvStatus;
  final RemoveTvWatchlist removeTvWatchlist;

  TvDetailNotifier(
      {required this.saveTvWatchlist,
      required this.removeTvWatchlist,
      required this.getTvRecomendation,
      required this.getWatchListTvStatus,
      required this.getTvDetail});

  late TvDetail _tvDetail;
  TvDetail get tvDetail => _tvDetail;

  RequestState _tvDetailState = RequestState.Empty;
  RequestState get tvDetailState => _tvDetailState;

  List<Tv> _recommendedTv = [];
  List<Tv> get recommendedTv => _recommendedTv;

  RequestState _recommendedTvState = RequestState.Empty;
  RequestState get recommendedTvState => _recommendedTvState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  Future<void> fetchTvDetail(int id) async {
    _tvDetailState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getTvDetail.execute(id);
    final recommendedResult = await getTvRecomendation.execute(id);
    detailResult.fold(
      (failure) {
        _message = failure.message;
        _tvDetailState = RequestState.Error;
        notifyListeners();
      },
      (tvDetail) {
        _recommendedTvState = RequestState.Loading;
        _tvDetail = tvDetail;
        notifyListeners();
        recommendedResult.fold(
          (failure) {
            _recommendedTvState = RequestState.Error;
            _message = failure.message;
          },
          (tvData) {
            _recommendedTvState = RequestState.Loaded;
            _recommendedTv = tvData;
          },
        );
        _tvDetailState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  String _watchListMessage = '';
  String get watchListMessage => _watchListMessage;

  Future<void> addWatchList(TvDetail tv) async {
    final result = await saveTvWatchlist.execute(tv);

    await result.fold(
      (failure) async {
        _watchListMessage = failure.message;
      },
      (successMessage) async {
        _watchListMessage = successMessage;
      },
    );
    await loadWatchlistStatus(tv.id);
  }

  Future<void> removeFromWatchList(TvDetail tv) async {
    final result = await removeTvWatchlist.execute(tv);

    await result.fold(
      (failure) async {
        _watchListMessage = failure.message;
      },
      (successMessage) {
        _watchListMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tv.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListTvStatus.execute(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }
}
