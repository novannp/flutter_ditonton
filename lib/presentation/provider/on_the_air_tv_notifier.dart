import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_on_the_air_tv.dart';
import 'package:flutter/material.dart';

class OnTheAirTvNotifier extends ChangeNotifier {
  final GetOnTheAirTv getOnTheAirTv;

  OnTheAirTvNotifier({required this.getOnTheAirTv});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  Future<void> fetchOnTheAirTv() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getOnTheAirTv.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (tvData) {
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
