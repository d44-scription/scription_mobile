import 'package:flutter_test/flutter_test.dart';
import 'package:scription_mobile/models/notable.dart';
import 'package:scription_mobile/notables/card.dart';
import 'package:flutter/material.dart';

void main() {
  group('Notables card widget', () {
    final notable1 = Notable(id: 1, name: 'Notable 1', description: 'Description 1');
    final notable2 = Notable(id: 1, name: 'Notable 2');

    testWidgets('Rendering title and description of notable',
        (WidgetTester tester) async {
      final widget = new MediaQuery(
          data: new MediaQueryData(),
          child: new MaterialApp(
              home: Scaffold(body: NotableCard(notable: notable1))));

      await tester.pumpWidget(widget);

      // Confirm title and Description are both shown
      expect(find.text('Notable 1'), findsOneWidget);
      expect(find.text('Description 1'), findsOneWidget);

      // Confirm second notable is not shown
      expect(find.text('Notable 2'), findsNWidgets(0));
      expect(find.text('Description 2'), findsNWidgets(0));
    });

    testWidgets('Rendering without a description', (WidgetTester tester) async {
      final widget = new MediaQuery(
          data: new MediaQueryData(),
          child: new MaterialApp(
              home: Scaffold(body: NotableCard(notable: notable2))));

      await tester.pumpWidget(widget);

      // Confirm it renders without description
      expect(find.text('Notable 2'), findsOneWidget);
      expect(find.text('Description 2'), findsNWidgets(0));

      // Confirm first notable is not shown
      expect(find.text('Notable 1'), findsNWidgets(0));
      expect(find.text('Description 1'), findsNWidgets(0));
    });
  });
}
