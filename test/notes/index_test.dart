import 'package:flutter_test/flutter_test.dart';
import 'package:scription_mobile/notes/index.dart';
import 'package:flutter/material.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:scription_mobile/http-common.dart';
import 'package:scription_mobile/constants.dart' as Constants;

void main() {
  group('Notes index widget', () {
    DioAdapter dioAdapter;

    final notebookId = 1;
    final notableId = 2;

    final notes = [
      {
        'id': 1,
        'content': 'Note 1',
      },
      {
        'id': 2,
        'content': 'Note 2',
      },
      {
        'id': 3,
        'content': 'Note 3',
      }
    ];

    setUpAll(() {
      // Set up mock dio adapter before all tests
      dioAdapter = DioAdapter();

      Http().dio.httpClientAdapter = dioAdapter;
    });

    testWidgets('Rendering card for each note', (WidgetTester tester) async {
      dioAdapter
          .onGet('/notebooks/$notebookId/notables/$notableId/notes')
          .reply(200, notes);

      final widget = new MediaQuery(
          data: new MediaQueryData(),
          child: new MaterialApp(
              home: Notes(notebookId: notebookId, notableId: notableId)));

      await tester.pumpWidget(widget);
      await tester.pump(Duration(seconds: 1));

      expect(find.text('Notes'), findsOneWidget);

      // Confirm cards are shown for each note
      expect(find.text('Note 1'), findsOneWidget);
      expect(find.text('Note 2'), findsOneWidget);
      expect(find.text('Note 3'), findsOneWidget);

      // Confirm 'no notes added' text is hidden
      expect(find.text(Constants.NO_CONTENT), findsNWidgets(0));
      expect(find.text(Constants.VISIT_WEB_APP), findsNWidgets(0));
    });

    testWidgets('When no notes available', (WidgetTester tester) async {
      dioAdapter
          .onGet('/notebooks/$notebookId/notables/$notableId/notes')
          .reply(200, []);

      final widget = new MediaQuery(
          data: new MediaQueryData(),
          child: new MaterialApp(
              home: Notes(notebookId: notebookId, notableId: notableId)));

      await tester.pumpWidget(widget);
      await tester.pump(Duration(seconds: 1));

      expect(find.text('Notes'), findsOneWidget);

      // Confirm no cards are rendered
      expect(find.text('Note 1'), findsNWidgets(0));
      expect(find.text('Note 2'), findsNWidgets(0));
      expect(find.text('Note 3'), findsNWidgets(0));

      // Confirm 'no notes added' text is shown
      // expect(find.text(Constants.NO_CONTENT), findsOneWidget);
      expect(find.text(Constants.VISIT_WEB_APP), findsOneWidget);
    });
  });
}
