import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ditonton/main.dart' as app;

extension on WidgetTester {
  Future<void> pumpApp() async {
    app.main();
    await pumpAndSettle();
  }
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Test', () {
    testWidgets('Ditonton App', (WidgetTester tester) async {
      // run App
      await tester.pumpApp();

      //find appbar
      expect(find.text('Ditonton | Movies'), findsOneWidget);

      //open drawer
      final ScaffoldState state = tester.firstState(find.byType(Scaffold));
      state.openDrawer();
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.tv));
      await tester.pumpAndSettle();
      expect(find.text('Ditonton | TV Series'), findsOneWidget);
      await tester.pumpAndSettle();
    });
  });
}
