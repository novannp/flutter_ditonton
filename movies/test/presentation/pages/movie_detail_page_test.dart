import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/presentation/bloc/movie/movies_bloc.dart';
import 'package:movies/presentation/pages/movies/movie_detail_page.dart';

import '../../dummy_data/movies/dummy_object.dart';
import '../../helper/test_bloc_helper.dart';

void main() {
  late MovieDetailBlocHelper movieDetailBlocHelper;
  late RecommendationsMovieBlocHelper recommendationsMovieBlocHelper;
  late WatchlistMovieBlocHelper watchlistMovieBlocHelper;

  setUpAll(() {
    movieDetailBlocHelper = MovieDetailBlocHelper();
    registerFallbackValue(MovieDetailEventHelper());
    registerFallbackValue(MovieDetailStateHelper());

    recommendationsMovieBlocHelper = RecommendationsMovieBlocHelper();
    registerFallbackValue(RecommendationsMovieEventHelper());
    registerFallbackValue(RecommendationsMovieStateHelper());

    watchlistMovieBlocHelper = WatchlistMovieBlocHelper();
    registerFallbackValue(WatchlistMovieEventHelper());
    registerFallbackValue(WatchlistMovieStateHelper());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailMovieBloc>(create: (_) => movieDetailBlocHelper),
        BlocProvider<WatchListBloc>(
          create: (_) => watchlistMovieBlocHelper,
        ),
        BlocProvider<RecommendationMovieBloc>(
          create: (_) => recommendationsMovieBlocHelper,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => movieDetailBlocHelper.state).thenReturn(MoviesLoading());
    when(() => watchlistMovieBlocHelper.state).thenReturn(MoviesLoading());
    when(() => recommendationsMovieBlocHelper.state)
        .thenReturn(MoviesLoading());

    final circularProgress = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(
      id: 1,
    )));
    await tester.pump();

    expect(circularProgress, findsOneWidget);
  });
  testWidgets(
      'Watchlist button should display + icon when movie not added to watch list',
      (WidgetTester tester) async {
    when(() => movieDetailBlocHelper.state)
        .thenReturn(MovieDetailHasData(testMovieDetail));
    when(() => recommendationsMovieBlocHelper.state)
        .thenReturn(MoviesHasData(testMovieList));
    when(() => watchlistMovieBlocHelper.state)
        .thenReturn(LoadWatchlistData(false));

    final watchListButtonIcon = find.byIcon(Icons.add);

    await tester
        .pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 97080)));
    await tester.pump();
    expect(watchListButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display check icon when movie added to watch list',
      (WidgetTester tester) async {
    when(() => movieDetailBlocHelper.state)
        .thenReturn(MovieDetailHasData(testMovieDetail));

    when(() => recommendationsMovieBlocHelper.state)
        .thenReturn(MoviesHasData(testMovieList));
    when(() => watchlistMovieBlocHelper.state)
        .thenReturn(LoadWatchlistData(true));

    final watchListButtonIcon = find.byIcon(Icons.check);

    await tester
        .pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 97080)));
    expect(watchListButtonIcon, findsOneWidget);
  });
}
