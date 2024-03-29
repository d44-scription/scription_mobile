import 'package:flutter_test/flutter_test.dart';
import 'package:scription_mobile/notebooks/card.dart';
import 'package:flutter/material.dart';

void main() {
  group('Notebooks card widget', () {
    final notebook1 = {'id': 1, 'name': 'Notebook 1', 'summary': 'Summary 1'};

    final notebook2 = {
      'id': 2,
      'name': 'Notebook 2',
    };

    testWidgets('Rendering title and summary of notebook',
        (WidgetTester tester) async {
      final widget = new MediaQuery(
          data: new MediaQueryData(),
          child: new MaterialApp(
              home: Scaffold(body: NotebookCard(data: notebook1))));

      await tester.pumpWidget(widget);

      // Confirm title and summary are both shown
      expect(find.text('Notebook 1'), findsOneWidget);
      expect(find.text('Summary 1'), findsOneWidget);

      // Confirm second notebook is not shown
      expect(find.text('Notebook 2'), findsNWidgets(0));
      expect(find.text('Summary 2'), findsNWidgets(0));
    });

    testWidgets('Rendering without a summary', (WidgetTester tester) async {
      final widget = new MediaQuery(
          data: new MediaQueryData(),
          child: new MaterialApp(
              home: Scaffold(body: NotebookCard(data: notebook2))));

      await tester.pumpWidget(widget);

      // Confirm it renders without summary
      expect(find.text('Notebook 2'), findsOneWidget);
      expect(find.text('Summary 2'), findsNWidgets(0));

      // Confirm first notebook is not shown
      expect(find.text('Notebook 1'), findsNWidgets(0));
      expect(find.text('Summary 1'), findsNWidgets(0));
    });
  });
}
