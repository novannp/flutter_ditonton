import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/entities/movie/movie.dart';
import 'package:search/domain/usecases/search_movies.dart';

import '../../helper/hellper.mocks.dart';

void main() {
  late SearchMovies usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = SearchMovies(mockMovieRepository);
  });
  String tQuery = 'query';
  final tMovies = <Movie>[];

  test('should get list of movie search result', () async {
    // arrange
    when(mockMovieRepository.searchMovies(tQuery))
        .thenAnswer((_) async => Right(tMovies));
    // act
    final result = await usecase.execute('query');
    // assert
    expect(result, Right(tMovies));
  });
}
