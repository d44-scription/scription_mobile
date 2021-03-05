import 'package:flutter_test/flutter_test.dart';
import 'package:scription_mobile/login.dart';
import 'package:flutter/material.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:scription_mobile/services/authentication.service.dart';
import 'package:scription_mobile/http-common.dart';

void main() {
  group('Login widget', () {
    DioAdapter dioAdapter;
    final widget = new MediaQuery(
        data: new MediaQueryData(), child: new MaterialApp(home: Login()));

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
      dioAdapter
          .onPost('/users/login')
          .reply(422, {}, headers: {'set-cookie': []});

      await tester.pumpWidget(widget);

      final emailFinder = find.widgetWithText(TextField, 'Email Address');
      final passwordFinder = find.widgetWithText(TextField, 'Password');
      final loginFinder = find.widgetWithText(ElevatedButton, 'Login');

      await tester.tap(loginFinder);
      await tester.pump();

      // Confirm local validations are shown
      expect(find.text('Please enter an email'), findsOneWidget);
      expect(find.text('Please enter a password'), findsOneWidget);
    });
  });
}
