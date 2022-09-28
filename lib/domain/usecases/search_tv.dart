import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entities/tv/tv.dart';
import '../repositories/tv_repository.dart';

class SearchTv {
  final TvRepository repository;

  SearchTv(this.repository);

  Future<Either<Failure, List<Tv>>> execute(String query) async {
    return await repository.searchTv(query);
  }
}
