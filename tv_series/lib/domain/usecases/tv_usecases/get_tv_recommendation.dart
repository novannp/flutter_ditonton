import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

import '../../entities/tv/tv.dart';
import '../../repositories/tv_repository.dart';

class GetTvRecomendation {
  final TvRepository repository;

  GetTvRecomendation(this.repository);

  Future<Either<Failure, List<Tv>>> execute(int id) async {
    return await repository.getTvRecommended(id);
  }
}
