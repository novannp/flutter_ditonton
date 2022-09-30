import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:core/domain/usecases/tv_usecases/get_popular_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetPopularTv(mockTvRepository);
  });
  final tTv = <Tv>[];
  test('should get popular tv list', () async {
    when(mockTvRepository.getPopularTv()).thenAnswer((_) async => Right(tTv));

    final result = await usecase.execute();
    expect(result, Right(tTv));
  });
}
