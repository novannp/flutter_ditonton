import 'package:dartz/dartz.dart';
import 'package:tv_series/domain/usecases/tv_usecases/remove_tv_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/tv/dummy_object.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveTvWatchlist usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = RemoveTvWatchlist(mockTvRepository);
  });
  test('should remove watchlist tv from repository', () async {
    // arrange
    when(mockTvRepository.removeTvWatchList(testTvDetail))
        .thenAnswer((_) async => const Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTvDetail);
    // assert
    verify(mockTvRepository.removeTvWatchList(testTvDetail));
    expect(result, const Right('Removed from watchlist'));
  });
}
