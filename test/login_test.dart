import 'package:flutter_test/flutter_test.dart';
import 'package:scription_mobile/login.dart';
import 'package:flutter/material.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:scription_mobile/http-common.dart';
import 'package:scription_mobile/constants.dart' as Constants;

void main() {
  group('Login widget', () {
    DioAdapter dioAdapter;

    final emailFinder = find.widgetWithText(TextField, Constants.EMAIL);
    final passwordFinder = find.widgetWithText(TextField, Constants.PASSWORD);
    final loginFinder = find.widgetWithText(ElevatedButton, Constants.LOGIN);
    final noAccountFinder = find.text(Constants.NO_ACCOUNT);
    final getStartedFinder = find.text(Constants.GET_STARTED);

    final error = {'errors': 'Test Error Message'};

    setUpAll(() {
      // Set up mock dio adapter before all tests
      dioAdapter = DioAdapter();

      Http().dio.httpClientAdapter = dioAdapter;
    });

    testWidgets('rendering correct widgets', (WidgetTester tester) async {
      final widget = new MediaQuery(
          data: new MediaQueryData(), child: new MaterialApp(home: Login()));
      await tester.pumpWidget(widget);

      expect(emailFinder, findsOneWidget);
      expect(passwordFinder, findsOneWidget);
      expect(loginFinder, findsOneWidget);
      expect(noAccountFinder, findsOneWidget);
      expect(getStartedFinder, findsOneWidget);
    });

    testWidgets('rendering with a message', (WidgetTester tester) async {
      final widget = new MediaQuery(
          data: new MediaQueryData(),
          child: new MaterialApp(home: Login(message: 'Test Message')));
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      expect(emailFinder, findsOneWidget);
      expect(passwordFinder, findsOneWidget);
      expect(loginFinder, findsOneWidget);
      expect(noAccountFinder, findsOneWidget);
      expect(getStartedFinder, findsOneWidget);
      expect(find.text('Test Message'), findsOneWidget);
    });

    testWidgets('On unsuccessful login', (WidgetTester tester) async {
      final widget = new MediaQuery(
          data: new MediaQueryData(), child: new MaterialApp(home: Login()));
      dioAdapter.onPost('/users/login').reply(422, error);

      await tester.pumpWidget(widget);

      // Submit form
      await tester.tap(loginFinder);
      await tester.pump(Duration(seconds: 1));

      // Confirm local validations are shown
      expect(find.text(Constants.ENTER_EMAIL), findsOneWidget);
      expect(find.text(Constants.ENTER_PASSWORD), findsOneWidget);

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
      expect(find.text(Constants.ENTER_EMAIL), findsNWidgets(0));
      expect(find.text(Constants.ENTER_PASSWORD), findsNWidgets(0));

      // Confirm response validations are shown
      expect(
          find.widgetWithText(SnackBar, 'Test Error Message'), findsOneWidget);
    });
  });
}
