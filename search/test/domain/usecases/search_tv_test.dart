import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_tv.dart';
import 'package:tv_series/domain/entities/tv/tv.dart';

import '../../helper/hellper.mocks.dart';

void main() {
  late SearchTv usecase;
  late MockTvRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockTvRepository();
    usecase = SearchTv(mockMovieRepository);
  });
  String tQuery = 'query';
  final tTv = <Tv>[];

  test('should get list of tv search result', () async {
    // arrange
    when(mockMovieRepository.searchTv(tQuery))
        .thenAnswer((_) async => Right(tTv));
    // act
    final result = await usecase.execute('query');
    // assert
    expect(result, Right(tTv));
  });
}
