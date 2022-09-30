import 'package:mocktail/mocktail.dart';
import 'package:core/presentation/widgets/list_card_shimmer.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/bloc/tv/tv_bloc.dart';
import 'package:tv_series/presentation/pages/tv/popular_tv_page.dart';

import '../../dummy_data/tv/dummy_object.dart';
import '../../helpers/test_bloc_helper.dart';

void main() {
  late PopularTvBlocHelper popularTvBlocHelper;
  setUpAll(() {
    popularTvBlocHelper = PopularTvBlocHelper();
    registerFallbackValue(PopularTvStateHelper());
    registerFallbackValue(PopularTvEventHelper());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvBloc>(
      create: (_) => popularTvBlocHelper,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    popularTvBlocHelper.close();
  });

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => popularTvBlocHelper.state).thenReturn(TvLoading());

    final progressBarFinder = find.byType(ListCardSimmer);

    await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => popularTvBlocHelper.state).thenReturn(TvLoading());
    when(() => popularTvBlocHelper.state).thenReturn(TvHasData(testTvList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => popularTvBlocHelper.state)
        .thenReturn(TvHasError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));

    expect(textFinder, findsOneWidget);
  });
}
