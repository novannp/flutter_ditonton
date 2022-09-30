import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/tv/tv.dart';
import '../entities/tv/tv_detail.dart';

abstract class TvRepository {
  Future<Either<Failure, List<Tv>>> getPopularTv();
  Future<Either<Failure, List<Tv>>> getTopRatedTv();
  Future<Either<Failure, List<Tv>>> getOnTheAirTv();
  Future<Either<Failure, TvDetail>> getTvDetail(int id);
  Future<Either<Failure, List<Tv>>> getTvRecommended(int id);
  Future<Either<Failure, List<Tv>>> searchTv(String query);
  Future<Either<Failure, String>> saveTvWatchList(TvDetail tv);
  Future<Either<Failure, String>> removeTvWatchList(TvDetail tv);
  Future<bool> isAddedToWatchList(int id);
  Future<Either<Failure, List<Tv>>> getTvWatchList();
}
