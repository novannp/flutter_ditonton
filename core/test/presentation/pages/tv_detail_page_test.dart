import 'package:core/presentation/provider/tv_detail_notifier.dart';
import 'package:core/utils/state_enum.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:core/presentation/pages/tv/tv_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_detail_page_test.mocks.dart';

@GenerateMocks([TvDetailNotifier])
void main() {
  late MockTvDetailNotifier mockTvDetailNotifier;

  setUp(() {
    mockTvDetailNotifier = MockTvDetailNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvDetailNotifier>.value(
      value: mockTvDetailNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display + icon when movie not added to watch list',
      (WidgetTester tester) async {
    when(mockTvDetailNotifier.tvDetailState).thenReturn(RequestState.Loaded);
    when(mockTvDetailNotifier.tvDetail).thenReturn(testTvDetail);
    when(mockTvDetailNotifier.recommendedTvState)
        .thenReturn(RequestState.Loaded);
    when(mockTvDetailNotifier.recommendedTv).thenReturn(<Tv>[]);
    when(mockTvDetailNotifier.isAddedToWatchlist).thenReturn(false);

    final watchListButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 97080)));
    expect(watchListButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display check icon when movie added to watch list',
      (WidgetTester tester) async {
    when(mockTvDetailNotifier.tvDetailState).thenReturn(RequestState.Loaded);
    when(mockTvDetailNotifier.tvDetail).thenReturn(testTvDetail);
    when(mockTvDetailNotifier.recommendedTvState)
        .thenReturn(RequestState.Loaded);
    when(mockTvDetailNotifier.recommendedTv).thenReturn(<Tv>[]);
    when(mockTvDetailNotifier.isAddedToWatchlist).thenReturn(true);

    final watchListButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 97080)));
    expect(watchListButtonIcon, findsOneWidget);
  });
}
