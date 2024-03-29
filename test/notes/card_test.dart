import 'package:flutter_test/flutter_test.dart';
import 'package:scription_mobile/notes/card.dart';
import 'package:flutter/material.dart';

void main() {
  group('Notes card widget', () {
    final note1 = {
      'id': 1,
      'content':
          'Note has content for @[Character 1](@1), #[Location 2](#2), and :[Item 3](:3)'
    };
    final note2 = {'id': 2, 'content': 'X' * 151};

    testWidgets('Rendering regex-cleaned text', (WidgetTester tester) async {
      final widget = new MediaQuery(
          data: new MediaQueryData(),
          child: new MaterialApp(home: Scaffold(body: NoteCard(data: note1))));

      await tester.pumpWidget(widget);

      // Confirm content is shown with mentions removed
      expect(
          find.text('Note has content for Character 1, Location 2, and Item 3'),
          findsOneWidget);
    });

    testWidgets('Rendering truncated text', (WidgetTester tester) async {
      final widget = new MediaQuery(
          data: new MediaQueryData(),
          child: new MaterialApp(home: Scaffold(body: NoteCard(data: note2))));

      await tester.pumpWidget(widget);

      // Confirm string is shortened and has an ellipses appended
      expect(find.text('${'X' * 150}...'), findsOneWidget);
    });
  });
}
