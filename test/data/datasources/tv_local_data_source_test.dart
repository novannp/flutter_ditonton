import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvLocalDataSource dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = TvLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('saveTvWatchList', () {
    test('should return success message', () async {
      when(mockDatabaseHelper.insertTvWatchList(testTvTable))
          .thenAnswer((_) async => 1);
      final result = await dataSource.insertTvWatchlist(testTvTable);

      expect(result, 'added to watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.insertTvWatchList(testTvTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertTvWatchlist(testTvTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success messahge when remove from db', () async {
      when(mockDatabaseHelper.removeTvWatchlist(testTvTable))
          .thenAnswer((_) async => 1);

      final result = await dataSource.removeTvWatchlist(testTvTable);
      expect(result, 'Removed ');
    });
    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.removeTvWatchlist(testTvTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeTvWatchlist(testTvTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('get tv detail by id', () {
    final tId = 1;
    test('should return Tv Detail Tabel when data found', () async {
      when(mockDatabaseHelper.getTvById(tId))
          .thenAnswer((_) async => testTvMap);

      final result = await dataSource.getTvById(tId);

      expect(result, testTvTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getTvById(tId)).thenAnswer((_) async => null);
      // act
      final result = await dataSource.getTvById(tId);
      // assert
      expect(result, null);
    });
  });
}
