import 'package:flutter_test/flutter_test.dart';
import 'package:scription_mobile/notables/index.dart';
import 'package:flutter/material.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:scription_mobile/http-common.dart';
import 'package:scription_mobile/constants.dart' as Constants;

void main() {
  group('Notables index widget', () {
    DioAdapter dioAdapter;

    final notebookId = 1;
    final notables = [
      {
        'id': 1,
        'name': 'Notable 1',
        'description': 'Notable 1 Description',
      },
      {
        'id': 2,
        'name': 'Notable 2',
      },
      {
        'id': 3,
        'name': 'Notable 3',
        'description': 'Notable 3 Description',
      }
    ];

    setUpAll(() {
      // Set up mock dio adapter before all tests
      dioAdapter = DioAdapter();

      Http().dio.httpClientAdapter = dioAdapter;
    });

    group('When characters', () {
      testWidgets('Rendering card for each character',
          (WidgetTester tester) async {
        dioAdapter
            .onGet('/notebooks/$notebookId/characters')
            .reply(200, notables);

        final widget = new MediaQuery(
            data: new MediaQueryData(),
            child: new MaterialApp(
                home: Notables(type: 'Characters', notebookId: notebookId)));

        await tester.pumpWidget(widget);
        await tester.pump(Duration(seconds: 1));

        expect(find.text('Characters'), findsOneWidget);

        // Confirm cards are shown for each notable
        expect(find.text('Notable 1'), findsOneWidget);
        expect(find.text('Notable 1 Description'), findsOneWidget);

        expect(find.text('Notable 2'), findsOneWidget);

        expect(find.text('Notable 3'), findsOneWidget);
        expect(find.text('Notable 3 Description'), findsOneWidget);

        // Confirm "no characters added" text is hidden
        expect(find.text('No characters added!'), findsNWidgets(0));
        expect(find.text(Constants.VISIT_WEB_APP), findsNWidgets(0));
      });

      testWidgets('When no notables available', (WidgetTester tester) async {
        dioAdapter.onGet('/notebooks/$notebookId/characters').reply(200, []);

        final widget = new MediaQuery(
            data: new MediaQueryData(),
            child: new MaterialApp(
                home: Notables(type: 'Characters', notebookId: notebookId)));

        await tester.pumpWidget(widget);
        await tester.pump(Duration(seconds: 1));

        expect(find.text('Characters'), findsOneWidget);

        // Confirm no cards are rendered
        expect(find.text('Notable 1'), findsNWidgets(0));
        expect(find.text('Notable 1 Description'), findsNWidgets(0));

        expect(find.text('Notable 2'), findsNWidgets(0));

        expect(find.text('Notable 3'), findsNWidgets(0));
        expect(find.text('Notable 3 Description'), findsNWidgets(0));

        // Confirm "no characters added" text is shown
        expect(find.text('No characters added!'), findsOneWidget);
        expect(find.text(Constants.VISIT_WEB_APP), findsOneWidget);
      });
    });
  });
}
