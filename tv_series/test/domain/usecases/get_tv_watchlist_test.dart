import 'package:dartz/dartz.dart';
import 'package:tv_series/domain/usecases/tv_usecases/get_watchlist_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/tv/dummy_object.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchListTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetWatchListTv(mockTvRepository);
  });

  test('should get watchlist tv from repository', () async {
    // arrange
    when(mockTvRepository.getTvWatchList())
        .thenAnswer((_) async => Right(testTvList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTvList));
  });
}
