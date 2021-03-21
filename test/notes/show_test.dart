import 'package:flutter_test/flutter_test.dart';
import 'package:scription_mobile/http-common.dart';
import 'package:scription_mobile/models/note.dart';
import 'package:scription_mobile/notes/show.dart';
import 'package:flutter/material.dart';

void main() {
  setUpAll(() {
    // Sign in before all tests
    Http().aToken = "Mock token";
  });

  group('Notes show widget', () {
    final note1 = Note(
        id: 1,
        content:
            'Note has content for @[Character 1](@1), #[Location 2](#2), and :[Item 3](:3)');
    final note2 = Note(id: 2, content: 'X' * 151);

    testWidgets('Rendering regex-cleaned text', (WidgetTester tester) async {
      final widget = new MediaQuery(
          data: new MediaQueryData(),
          child: new MaterialApp(home: Show(note: note1)));

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      // Confirm content is shown with mentions removed
      expect(
          find.text('Note has content for Character 1, Location 2, and Item 3'),
          findsOneWidget);
    });

    testWidgets('Rendering full text', (WidgetTester tester) async {
      final widget = new MediaQuery(
          data: new MediaQueryData(),
          child: new MaterialApp(home: Show(note: note2)));

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      // Confirm content is show untruncated
      expect(find.text('X' * 151), findsOneWidget);
    });
  });
}
