import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvRecomendation usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvRecomendation(mockTvRepository);
  });

  final tId = 1;
  final tTv = <Tv>[];

  test('should get list tv recommend', () async {
    when(mockTvRepository.getTvRecommended(tId))
        .thenAnswer((_) async => Right(tTv));

    final result = await usecase.execute(tId);
    expect(result, Right(tTv));
  });
}
