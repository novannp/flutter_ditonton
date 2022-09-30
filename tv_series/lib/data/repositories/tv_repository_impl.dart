import 'package:core/utils/exception.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/tv/tv.dart';
import '../../domain/entities/tv/tv_detail.dart';
import '../../domain/repositories/tv_repository.dart';

import '../datasources/tv_local_data_source.dart';
import '../datasources/tv_remote_data_source.dart';
import '../models/tv/tv_table.dart';

class TvRepositoryImpl implements TvRepository {
  final TvRemoteDataSource remoteDataSource;
  final TvLocalDataSource localDataSource;

  TvRepositoryImpl(
      {required this.localDataSource, required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Tv>>> getPopularTv() async {
    try {
      final result = await remoteDataSource.getPopularTv();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerFailure {
      return Left(ServerFailure(''));
    } on ConnectionFailure {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getTopRatedTv() async {
    try {
      final result = await remoteDataSource.getTopRatedTv();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerFailure {
      return Left(ServerFailure(''));
    } on ConnectionFailure {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, TvDetail>> getTvDetail(int id) async {
    try {
      final result = await remoteDataSource.getTvDetail(id);
      return Right(result.toEntity());
    } on ServerFailure {
      return Left(ServerFailure(''));
    } on ConnectionFailure {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> searchTv(String query) async {
    try {
      final result = await remoteDataSource.searchTv(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerFailure {
      return Left(ServerFailure(''));
    } on ConnectionFailure {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getOnTheAirTv() async {
    try {
      final result = await remoteDataSource.getOnTheAirTv();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerFailure {
      return Left(ServerFailure(''));
    } on ConnectionFailure {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getTvRecommended(int id) async {
    try {
      final result = await remoteDataSource.getTvRecommendations(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerFailure {
      return Left(ServerFailure(''));
    } on ConnectionFailure {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getTvWatchList() async {
    final result = await localDataSource.getWatchlistTv();
    return Right(result.map((e) => e.toEntity()).toList());
  }

  @override
  Future<bool> isAddedToWatchList(int id) async {
    final result = await localDataSource.getTvById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> removeTvWatchList(TvDetail tv) async {
    try {
      final result =
          await localDataSource.removeTvWatchlist(TvTable.fromEntity(tv));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> saveTvWatchList(TvDetail tv) async {
    try {
      final result =
          await localDataSource.insertTvWatchlist(TvTable.fromEntity(tv));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }
}
