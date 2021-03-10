import 'package:flutter_test/flutter_test.dart';
import 'package:scription_mobile/notebooks/index.dart';
import 'package:flutter/material.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:scription_mobile/http-common.dart';

void main() {
  group('Notebooks index widget', () {
    DioAdapter dioAdapter;

    final notebooks = [
      {
        'id': 1,
        'name': 'Notebook 1',
        'summary': 'Notebook 1 Summary',
      },
      {
        'id': 2,
        'name': 'Notebook 2',
      },
      {
        'id': 3,
        'name': 'Notebook 3',
        'summary': 'Notebook 3 Summary',
      }
    ];

    setUpAll(() {
      // Set up mock dio adapter before all tests
      dioAdapter = DioAdapter();

      Http().dio.httpClientAdapter = dioAdapter;
    });

    testWidgets('Rendering card for each notebook', (WidgetTester tester) async {
      dioAdapter.onGet('/notebooks').reply(200, notebooks);

      final widget = new MediaQuery(
          data: new MediaQueryData(),
          child: new MaterialApp(home: Notebooks()));

      await tester.pumpWidget(widget);
      await tester.pump(Duration(seconds: 1));

      expect(find.text('Notebooks'), findsOneWidget);

      // Confirm cards are shown for each notebook
      expect(find.text('Notebook 1'), findsOneWidget);
      expect(find.text('Notebook 1 Summary'), findsOneWidget);

      expect(find.text('Notebook 2'), findsOneWidget);

      expect(find.text('Notebook 3'), findsOneWidget);
      expect(find.text('Notebook 3 Summary'), findsOneWidget);

      // Confirm "no notebooks added" text is hidden
      expect(find.text('No notebooks added!'), findsNWidgets(0));
      expect(find.text('Please visit the Scription Web App to set up your content'), findsNWidgets(0));
    });

    testWidgets('When no notebooks available', (WidgetTester tester) async {
      dioAdapter.onGet('/notebooks').reply(200, []);

      final widget = new MediaQuery(
          data: new MediaQueryData(),
          child: new MaterialApp(home: Notebooks()));

      await tester.pumpWidget(widget);
      await tester.pump(Duration(seconds: 1));

      expect(find.text('Notebooks'), findsOneWidget);

      // Confirm no cards are rendered
      expect(find.text('Notebook 1'), findsNWidgets(0));
      expect(find.text('Notebook 1 Summary'), findsNWidgets(0));

      expect(find.text('Notebook 2'), findsNWidgets(0));

      expect(find.text('Notebook 3'), findsNWidgets(0));
      expect(find.text('Notebook 3 Summary'), findsNWidgets(0));

      // Confirm "no notebooks added" text is shown
      expect(find.text('No notebooks added!'), findsOneWidget);
      expect(find.text('Please visit the Scription Web App to set up your content'), findsOneWidget);
    });
  });
}