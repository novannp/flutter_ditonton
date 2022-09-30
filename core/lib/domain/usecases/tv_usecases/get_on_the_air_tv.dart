import 'package:dartz/dartz.dart';

import '../../../utils/failure.dart';
import '../../entities/tv/tv.dart';
import '../../repositories/tv_repository.dart';

class GetOnTheAirTv {
  final TvRepository repository;

  GetOnTheAirTv(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getOnTheAirTv();
  }
}
