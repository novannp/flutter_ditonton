import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_on_the_air_tv.dart';
import 'package:ditonton/domain/usecases/get_popular_tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/tv/tv.dart';

class TvListNotifier extends ChangeNotifier {
  var _popularTv = <Tv>[];

  List<Tv> get popularTv => _popularTv;

  RequestState _popularTvState = RequestState.Empty;
  RequestState get popularState => _popularTvState;

  var _topRatedTv = <Tv>[];
  List<Tv> get topRatedTv => _topRatedTv;

  RequestState _topRatedTvState = RequestState.Empty;
  RequestState get topRatedTvState => _topRatedTvState;

  var _tvSearch = <Tv>[];
  List<Tv> get tvSearch => _tvSearch;

  RequestState _tvSearchState = RequestState.Empty;
  RequestState get tvSearchState => _tvSearchState;

  var _onTheAirTv = <Tv>[];
  List<Tv> get onTheAirTv => _onTheAirTv;

  RequestState _onTheAirTvState = RequestState.Empty;
  RequestState get onTheAirTvState => _onTheAirTvState;

  String _message = '';
  String get message => _message;

  TvListNotifier(
      {required this.getOnTheAirTv,
      required this.getTopRatedTv,
      required this.getPopularTv});

  final GetOnTheAirTv getOnTheAirTv;
  final GetTopRatedTv getTopRatedTv;
  final GetPopularTv getPopularTv;

  Future<void> fetchPopularTv() async {
    _popularTvState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTv.execute();

    result.fold((failure) {
      _message = failure.message;
      _popularTvState = RequestState.Error;
      notifyListeners();
    }, (tvData) {
      _popularTv = tvData;
      _popularTvState = RequestState.Loaded;
      notifyListeners();
    });
  }

  Future<void> fetchTopRatedTv() async {
    _topRatedTvState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTv.execute();

    result.fold((failure) {
      _message = failure.message;
      _topRatedTvState = RequestState.Error;
      notifyListeners();
    }, (tvData) {
      _topRatedTv = tvData;
      _topRatedTvState = RequestState.Loaded;
      notifyListeners();
    });
  }

  Future<void> fetchOnTheAirTv() async {
    _onTheAirTvState = RequestState.Loading;
    notifyListeners();

    final result = await getOnTheAirTv.execute();

    result.fold((failure) {
      _message = failure.message;
      _onTheAirTvState = RequestState.Error;
      notifyListeners();
    }, (tvData) {
      _onTheAirTv = tvData;
      _onTheAirTvState = RequestState.Loaded;
      notifyListeners();
    });
  }
}
