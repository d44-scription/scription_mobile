import 'package:flutter_test/flutter_test.dart';
import 'package:scription_mobile/login.dart';
import 'package:flutter/material.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:scription_mobile/http-common.dart';

void main() {
  group('Login widget', () {
    DioAdapter dioAdapter;
    final widget = new MediaQuery(
        data: new MediaQueryData(), child: new MaterialApp(home: Login()));

    final error = {'errors': "Test Error Message"};

    setUpAll(() {
      // Set up mock dio adapter before all tests
      dioAdapter = DioAdapter();

      Http().dio.httpClientAdapter = dioAdapter;
    });

    testWidgets('Login widget', (WidgetTester tester) async {
      await tester.pumpWidget(widget);

      final emailFinder = find.widgetWithText(TextField, 'Email Address');
      final passwordFinder = find.widgetWithText(TextField, 'Password');
      final loginFinder = find.widgetWithText(ElevatedButton, 'Login');

      expect(emailFinder, findsOneWidget);
      expect(passwordFinder, findsOneWidget);
      expect(loginFinder, findsOneWidget);
    });

    testWidgets('On unsuccessful login', (WidgetTester tester) async {
      dioAdapter.onPost('/users/login').reply(422, error);

      await tester.pumpWidget(widget);

      final emailFinder = find.widgetWithText(TextField, 'Email Address');
      final passwordFinder = find.widgetWithText(TextField, 'Password');
      final loginFinder = find.widgetWithText(ElevatedButton, 'Login');

      // Submit form
      await tester.tap(loginFinder);
      await tester.pump(Duration(seconds: 1));

      // Confirm local validations are shown
      expect(find.text('Please enter an email'), findsOneWidget);
      expect(find.text('Please enter a password'), findsOneWidget);

      // Confirm response validations are not shown
      expect(find.widgetWithText(SnackBar, 'Test Error Message'),
          findsNWidgets(0));

      // Enter email and password
      await tester.enterText(emailFinder, 'admin@example.com');
      await tester.enterText(passwordFinder, 'superSecret123!');

      // Submit form
      await tester.tap(loginFinder);
      await tester.pump(Duration(seconds: 1));

      // Confirm local validations are removed
      expect(find.text('Please enter an email'), findsNWidgets(0));
      expect(find.text('Please enter a password'), findsNWidgets(0));

      // Confirm response validations are shown
      expect(
          find.widgetWithText(SnackBar, 'Test Error Message'), findsOneWidget);
    });
  });
}
