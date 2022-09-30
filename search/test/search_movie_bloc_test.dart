import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movie/movie.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';

import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:search/domain/usecases/search_movies.dart';
import 'package:search/presentation/bloc/search_movies_bloc.dart';

import 'search_movie_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late MockSearchMovies mockSearchMovies;
  late SearchMoviesBloc searchMoviebloc;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    searchMoviebloc = SearchMoviesBloc(mockSearchMovies);
  });

  group('search movie bloc test', () {
    final tMovieModel = Movie(
      adult: false,
      backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
      genreIds: const [14, 28],
      id: 557,
      originalTitle: 'Spider-Man',
      overview:
          'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
      popularity: 60.441,
      posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
      releaseDate: '2002-05-01',
      title: 'Spider-Man',
      video: false,
      voteAverage: 7.2,
      voteCount: 13507,
    );
    final tMovieList = <Movie>[tMovieModel];
    const tQuery = 'spiderman';
    test('initial state should be empty', () {
      expect(searchMoviebloc.state, SearchEmpty());
    });

    blocTest<SearchMoviesBloc, SearchState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => Right(tMovieList));
        return searchMoviebloc;
      },
      act: (bloc) => bloc.add(OnTvQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        SearchMovieHasData(tMovieList),
      ],
      verify: (bloc) {
        verify(mockSearchMovies.execute(tQuery));
      },
    );
  });
}
