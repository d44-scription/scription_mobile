import 'package:flutter_test/flutter_test.dart';
import 'package:scription_mobile/http-common.dart';
import 'package:scription_mobile/notebooks/dashboard-tile.dart';
import 'package:flutter/material.dart';

void main() {
  const title = 'Test Title';
  const subtitle = 'Test Subtitle';

  setUpAll(() {
    // Sign in before all tests
    Http().aToken = 'Mock token';
  });

  group('Dashboard tile widget', () {
    testWidgets('Rendering title and summary', (WidgetTester tester) async {
      final widget = new MediaQuery(
          data: new MediaQueryData(),
          child: new MaterialApp(
              home: Scaffold(
                  body: DashboardTile(title: title, subtitle: subtitle))));

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      // Confirm title and subtitle are both shown
      expect(find.text(title), findsOneWidget);
      expect(find.text(subtitle), findsOneWidget);
    });
  });
}
