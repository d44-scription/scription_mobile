import 'package:flutter_test/flutter_test.dart';
import 'package:scription_mobile/http-common.dart';
import 'package:scription_mobile/models/notebook.dart';
import 'package:scription_mobile/notebooks/dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  setUpAll(() {
    // Sign in before all tests
    Http().aToken = "Mock token";
  });

  group('Notebooks dashboard widget', () {
    final notebook1 = Notebook(id: 1, name: 'Notebook 1', summary: 'Summary 1');
    final notebook2 = Notebook(id: 1, name: 'Notebook 2');

    testWidgets('Rendering title and summary of notebook',
        (WidgetTester tester) async {
      final widget = new MediaQuery(
          data: new MediaQueryData(),
          child: new MaterialApp(
              home: Dashboard(
            notebook: notebook1,
          )));

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      // Confirm title and summary are both shown
      expect(find.text('Notebook 1'), findsOneWidget);
      expect(find.text('Summary 1'), findsOneWidget);

      // Confirm navigation buttons are rendered
      expect(find.text('Characters'), findsOneWidget);
      expect(find.text('View characters for Notebook 1'), findsOneWidget);

      expect(find.text('Items'), findsOneWidget);
      expect(find.text('View items for Notebook 1'), findsOneWidget);

      expect(find.text('Locations'), findsOneWidget);
      expect(find.text('View locations for Notebook 1'), findsOneWidget);

      // Confirm second notebook is not shown
      expect(find.text('Notebook 2'), findsNWidgets(0));
      expect(find.text('Summary 2'), findsNWidgets(0));
    });

    testWidgets('Rendering without a summary', (WidgetTester tester) async {
      final widget = new MediaQuery(
          data: new MediaQueryData(),
          child: new MaterialApp(
              home: Dashboard(
            notebook: notebook2,
          )));

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      // Confirm it renders without summary
      expect(find.text('Notebook 2'), findsOneWidget);
      expect(find.text('Summary 2'), findsNWidgets(0));

      // Confirm navigation buttons are rendered
      expect(find.text('Characters'), findsOneWidget);
      expect(find.text('View characters for Notebook 2'), findsOneWidget);

      expect(find.text('Items'), findsOneWidget);
      expect(find.text('View items for Notebook 2'), findsOneWidget);

      expect(find.text('Locations'), findsOneWidget);
      expect(find.text('View locations for Notebook 2'), findsOneWidget);

      // Confirm first notebook is not shown
      expect(find.text('Notebook 1'), findsNWidgets(0));
      expect(find.text('Summary 1'), findsNWidgets(0));
    });
  });
}
