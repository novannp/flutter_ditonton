import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';

import '../../common/failure.dart';
import '../repositories/tv_repository.dart';

class SaveTvWatchlist {
  final TvRepository repository;

  SaveTvWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return repository.saveTvWatchList(tv);
  }
}
