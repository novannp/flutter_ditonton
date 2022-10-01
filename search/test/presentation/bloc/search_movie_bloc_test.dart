import 'package:bloc_test/bloc_test.dart';
import 'package:movies/domain/entities/movie/movie.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';

import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:search/domain/usecases/search_movies.dart';
import 'package:search/domain/usecases/search_tv.dart';
import 'package:search/presentation/bloc/search_movies_bloc.dart';
import 'package:tv_series/domain/entities/tv/tv.dart';

import 'search_movie_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies, SearchTv])
void main() {
  late MockSearchMovies mockSearchMovies;
  late MockSearchTv mockSearchTv;
  late SearchMoviesBloc searchMoviebloc;
  late SearchTvBloc searchTvBloc;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    mockSearchTv = MockSearchTv();
    searchMoviebloc = SearchMoviesBloc(mockSearchMovies);
    searchTvBloc = SearchTvBloc(mockSearchTv);
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
      act: (bloc) => bloc.add(OnMovieQueryChanged(tQuery)),
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
  group('search tv bloc test', () {
    final tTvModel = Tv(
        backdropPath: '/Aa9TLpNpBMyRkD8sPJ7ACKLjt0l.jpg',
        firstAirDate: DateTime.parse("2022-08-21"),
        genreIds: [10765, 18, 10759],
        id: 94997,
        name: 'House of the Dragon',
        originCountry: ["US"],
        originalLanguage: "en",
        originalName: "House of the Dragon",
        overview:
            "The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.",
        popularity: 9289.748,
        posterPath: '/z2yahl2uefxDCl0nogcRBstwruJ.jpg',
        voteAverage: 8.7,
        voteCount: 1076);
    final tTvList = <Tv>[tTvModel];
    const tQuery = 'house';
    test('initial state should be empty', () {
      expect(searchMoviebloc.state, SearchEmpty());
    });

    blocTest<SearchTvBloc, SearchState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockSearchTv.execute(tQuery))
            .thenAnswer((_) async => Right(tTvList));
        return searchTvBloc;
      },
      act: (bloc) => bloc.add(OnTvQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        SearchTvHasData(tTvList),
      ],
      verify: (bloc) {
        verify(mockSearchTv.execute(tQuery));
      },
    );
  });
}
