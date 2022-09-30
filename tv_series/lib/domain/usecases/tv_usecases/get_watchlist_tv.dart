import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

import '../../entities/tv/tv.dart';
import '../../repositories/tv_repository.dart';

class GetWatchListTv {
  final TvRepository _repository;

  GetWatchListTv(this._repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return _repository.getTvWatchList();
  }
}
