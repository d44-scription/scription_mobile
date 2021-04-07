import 'package:flutter_test/flutter_test.dart';
import 'package:scription_mobile/notables/card.dart';
import 'package:flutter/material.dart';

void main() {
  group('Notables card widget', () {
    final notable1 = {
      'id': 1,
      'name': 'Notable 1',
      'description': 'Description 1'
    };
    final notable2 = {'id': 1, 'name': 'Notable 2'};
    final notable3 = {
      'id': 1,
      'name': 'Notable 3',
      'description':
          'Description that mentions @[Character 1](@1), #[Location 2](#2), and :[Item 3](:3)'
    };
    final notable4 = {'id': 1, 'name': 'Notable 4', 'description': 'X' * 151};

    testWidgets('Rendering title and description of notable',
        (WidgetTester tester) async {
      final widget = new MediaQuery(
          data: new MediaQueryData(),
          child: new MaterialApp(
              home: Scaffold(body: NotableCard(data: notable1))));

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
              home: Scaffold(body: NotableCard(data: notable2))));

      await tester.pumpWidget(widget);

      // Confirm it renders without description
      expect(find.text('Notable 2'), findsOneWidget);
      expect(find.text('Description 2'), findsNWidgets(0));

      // Confirm first notable is not shown
      expect(find.text('Notable 1'), findsNWidgets(0));
      expect(find.text('Description 1'), findsNWidgets(0));
    });

    testWidgets('Rendering regex-cleaned text', (WidgetTester tester) async {
      final widget = new MediaQuery(
          data: new MediaQueryData(),
          child: new MaterialApp(
              home: Scaffold(body: NotableCard(data: notable3))));

      await tester.pumpWidget(widget);

      // Confirm description has mentions removed
      expect(find.text('Notable 3'), findsOneWidget);
      expect(
          find.text(
              'Description that mentions Character 1, Location 2, and Item 3'),
          findsOneWidget);
    });

    testWidgets('Rendering truncated text', (WidgetTester tester) async {
      final widget = new MediaQuery(
          data: new MediaQueryData(),
          child: new MaterialApp(
              home: Scaffold(body: NotableCard(data: notable4))));

      await tester.pumpWidget(widget);

      // Confirm string is shortened and has an ellipses appended
      expect(find.text('Notable 4'), findsOneWidget);
      expect(find.text('${'X' * 150}...'), findsOneWidget);
    });
  });
}
