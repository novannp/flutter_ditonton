import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/repositories/tv_repository_impl.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvRepositoryImpl repository;
  late MockTvRemoteDataSource mockTvRemoteDataSource;
  late MockTvLocalDataSource mockTvLocalDataSource;

  setUp(() {
    mockTvLocalDataSource = MockTvLocalDataSource();
    mockTvRemoteDataSource = MockTvRemoteDataSource();
    repository = TvRepositoryImpl(
      remoteDataSource: mockTvRemoteDataSource,
      localDataSource: mockTvLocalDataSource,
    );
  });

  final tTvModel = TvModel(
    backdropPath: '/backdropPath',
    firstAirDate: DateTime.parse('2021-01-01'),
    genreIds: [1, 2],
    id: 1,
    name: 'name',
    originCountry: ['US'],
    originalLanguage: 'en',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1.0,
    posterPath: '/posterPath',
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tTv = Tv(
    backdropPath: '/backdropPath',
    firstAirDate: DateTime.parse('2021-01-01'),
    genreIds: [1, 2],
    id: 1,
    name: 'name',
    originCountry: ['US'],
    originalLanguage: 'en',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1.0,
    posterPath: '/posterPath',
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tTvModelList = <TvModel>[tTvModel];
  final tTvList = <Tv>[tTv];

  group('On The Air', () {
    test('shoud return remote data', () async {
      when(mockTvRemoteDataSource.getOnTheAirTv())
          .thenAnswer((_) async => tTvModelList);

      final result = await repository.getOnTheAirTv();

      verify(mockTvRemoteDataSource.getOnTheAirTv());

      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });
    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getOnTheAirTv())
          .thenAnswer((_) => throw ServerFailure(''));
      // act
      final result = await repository.getOnTheAirTv();
      // assert
      verify(mockTvRemoteDataSource.getOnTheAirTv());
      expect(result, equals(Left(ServerFailure(''))));
    });
  });

  group('Popular Tv', () {
    test('shoud return remote data', () async {
      when(mockTvRemoteDataSource.getPopularTv())
          .thenAnswer((_) async => tTvModelList);

      final result = await repository.getPopularTv();

      verify(mockTvRemoteDataSource.getPopularTv());

      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getPopularTv()).thenThrow(ServerFailure(''));
      // act
      final result = await repository.getPopularTv();
      // assert
      expect(result, Left(ServerFailure('')));
    });
  });

  group('Top Rated Tv', () {
    test('shoud return remote data', () async {
      when(mockTvRemoteDataSource.getTopRatedTv())
          .thenAnswer((_) async => tTvModelList);

      final result = await repository.getTopRatedTv();

      verify(mockTvRemoteDataSource.getTopRatedTv());

      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTopRatedTv())
          .thenAnswer((_) => throw ServerFailure(''));
      // act
      final result = await repository.getTopRatedTv();
      // assert
      verify(mockTvRemoteDataSource.getTopRatedTv());
      expect(result, equals(Left(ServerFailure(''))));
    });
  });
}
