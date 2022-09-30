import 'package:core/presentation/widgets/list_card_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/presentation/bloc/movie/movies_bloc.dart';
import 'package:movies/presentation/pages/movies/top_rated_movies_page.dart';

import '../../dummy_data/movies/dummy_object.dart';
import '../../helper/test_bloc_helper.dart';

void main() {
  late TopRatedMoviesBlocHelper topRatedMoviesBlocHelper;

  setUpAll(() {
    topRatedMoviesBlocHelper = TopRatedMoviesBlocHelper();
    registerFallbackValue(TopRatedMoviesBlocHelper());
    registerFallbackValue(TopRatedMoviesStateHelper());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedMoviesBloc>(
      create: (_) => topRatedMoviesBlocHelper,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => topRatedMoviesBlocHelper.state).thenReturn(MoviesLoading());

    final progressFinder = find.byType(ListCardSimmer);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => topRatedMoviesBlocHelper.state)
        .thenAnswer((invocation) => MoviesLoading());
    when(() => topRatedMoviesBlocHelper.state)
        .thenReturn(MoviesHasData(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => topRatedMoviesBlocHelper.state)
        .thenReturn(MoviesHasError('Error'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
