import 'package:flutter_test/flutter_test.dart';
import 'package:scription_mobile/global-navigation.dart';
import 'package:flutter/material.dart';
import 'package:scription_mobile/http-common.dart';

void main() {
  setUpAll(() {
    // Sign in before all tests
    Http().aToken = "Mock token";
  });

  group('Global navigation widget', () {
    final String title = 'Test Title';
    final String body = 'Test Widget';

    final Widget bodyWidget = Text(body);

    final drawerFinder = find.byTooltip('Open navigation menu');

    testWidgets('Rendering given widget', (WidgetTester tester) async {
      final widget = new MediaQuery(
          data: new MediaQueryData(),
          child: new MaterialApp(
              home: GlobalNavigation(title: title, body: bodyWidget)));

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      expect(find.text(title), findsOneWidget);
      expect(find.text(body), findsOneWidget);
      expect(find.text('Logout'), findsNWidgets(0));

      await tester.tap(drawerFinder);
      await tester.pumpWidget(widget);

      expect(find.text('Logout'), findsOneWidget);
    });

    testWidgets('Rendering without title', (WidgetTester tester) async {
      final widget = new MediaQuery(
          data: new MediaQueryData(),
          child: new MaterialApp(
              home: GlobalNavigation(body: bodyWidget)));

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      expect(find.text('Index'), findsOneWidget);
      expect(find.text(body), findsOneWidget);
      expect(find.text(title), findsNWidgets(0));
      expect(find.text('Logout'), findsNWidgets(0));
    });
  });
}
