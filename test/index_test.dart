import 'package:flutter_test/flutter_test.dart';
import 'package:scription_mobile/index.dart';
import 'package:flutter/material.dart';
import 'package:scription_mobile/constants.dart' as Constants;

void main() {
  group('Global index widget', () {
    final _data = [
      {"1": "Test String 1"},
      {"2": "Test String 2"}
    ];

    Widget _cardBuilder({Map<String, dynamic> data}) {
      if (data != null) {
        return Text(data.values.last);
      }

      return CircularProgressIndicator();
    }

    Future<dynamic> _successfulCallback() async {
      return Future.delayed(Duration(milliseconds: 1), () => _data);
    }

    Future<dynamic> _unsuccessfulCallback() async {
      return Future.delayed(Duration(milliseconds: 1), () => []);
    }

    testWidgets('Rendering card for each list item',
        (WidgetTester tester) async {
      final widget = new MediaQuery(
          data: new MediaQueryData(),
          child: new MaterialApp(
              home: Index(
            display: _cardBuilder,
            callback: _successfulCallback,
          )));

      await tester.pumpWidget(widget);
      await tester.pump(Duration(seconds: 1));

      // Confirm cards are shown for each notebook
      expect(find.text('Test String 1'), findsOneWidget);
      expect(find.text('Test String 2'), findsOneWidget);

      // Confirm 'no content' text is hidden
      expect(find.text(Constants.NO_CONTENT), findsNWidgets(0));
      expect(find.text(Constants.VISIT_WEB_APP), findsNWidgets(0));
    });

    testWidgets('When no items given', (WidgetTester tester) async {
      final widget = new MediaQuery(
          data: new MediaQueryData(),
          child: new MaterialApp(
              home: Index(
            display: _cardBuilder,
            callback: _unsuccessfulCallback,
          )));

      await tester.pumpWidget(widget);
      await tester.pump(Duration(seconds: 1));

      // Confirm cards are shown for each notebook
      expect(find.text('Test String 1'), findsNWidgets(0));
      expect(find.text('Test String 2'), findsNWidgets(0));

      // Confirm 'no content' text is hidden
      expect(find.text(Constants.NO_CONTENT), findsOneWidget);
      expect(find.text(Constants.VISIT_WEB_APP), findsOneWidget);
    });
  });
}
