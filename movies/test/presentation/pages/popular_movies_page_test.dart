import 'package:mocktail/mocktail.dart';
import 'package:movies/presentation/pages/movies/popular_movies_page.dart';
import 'package:core/presentation/widgets/list_card_shimmer.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies/presentation/bloc/movie/movies_bloc.dart';
import '../../dummy_data/movies/dummy_object.dart';
import '../../helper/test_bloc_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  late PopularMoviesBlocHelper popularMoviesBlocHelper;
  setUpAll(() {
    popularMoviesBlocHelper = PopularMoviesBlocHelper();
    registerFallbackValue(PopularMoviesStateHelper());
    registerFallbackValue(PopularMoviesEventHelper());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularMoviesBloc>(
      create: (_) => popularMoviesBlocHelper,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    popularMoviesBlocHelper.close();
  });

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => popularMoviesBlocHelper.state).thenReturn(MoviesLoading());

    final progressBarFinder = find.byType(ListCardSimmer);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => popularMoviesBlocHelper.state).thenReturn(MoviesLoading());
    when(() => popularMoviesBlocHelper.state)
        .thenReturn(MoviesHasData(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => popularMoviesBlocHelper.state)
        .thenReturn(MoviesHasError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
