import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:flutter_testing/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets(
      'tap on the floating action button, verify counter',
      (tester) async {
        app.main();
        await tester.pumpAndSettle();

        // Verify the counter starts at 0.
        expect(find.text('0'), findsOneWidget);

        // Finds the floating action button to tap on.
        final Finder fab = find.byTooltip('Increment');

        // Emulate a tap on the floating action button.
        await tester.tap(fab);

        // Trigger a frame.
        await tester.pumpAndSettle();

        // Verify the counter increments by 1.
        expect(find.text('1'), findsOneWidget);
      },
    );

    testWidgets(
      'Go to second page, verify text',
      (tester) async {
        app.main();
        await tester.pumpAndSettle();

        // Verify the counter starts at 0.
        expect(find.byKey(const ValueKey('goToSecondPage')), findsOneWidget);

        // Finds the floating action button to tap on.
        final Finder fab = find.byKey(const ValueKey('goToSecondPage'));

        // Emulate a tap on the floating action button.
        await tester.tap(fab);

        // Trigger a frame.
        await tester.pumpAndSettle();

        expect(
          find.byKey(const ValueKey('secondPageText')),
          findsOneWidget,
        );

        final Finder code = find.byKey(const ValueKey('code'));

        expect(code, findsOneWidget);

        final value = (tester.widget(code) as Text).data;

        // Assert that the value is not empty
        expect(value, isNotEmpty);
        expect(value, '453ac');

        await Future.delayed(const Duration(seconds: 10));
      },
    );
  });
}
