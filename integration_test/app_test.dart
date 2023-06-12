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

        await Future.delayed(const Duration(seconds: 2));

        // Trigger a frame.
        await tester.pumpAndSettle();

        expect(
          find.byKey(const ValueKey('secondPageText')),
          findsOneWidget,
        );

        await Future.delayed(const Duration(seconds: 10));
      },
    );
  });
}
