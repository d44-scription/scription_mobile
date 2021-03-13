import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:scription_mobile/http-common.dart';

// The application under test.
import 'package:scription_mobile/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  final _storage = new FlutterSecureStorage();
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

  group('login page', () {
    group('with no stored token', () {
      setUpAll(() async {
        await _storage.deleteAll();
      });

      testWidgets('render login page', (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle();

        final emailFinder = find.widgetWithText(TextField, 'Email Address');
        final passwordFinder = find.widgetWithText(TextField, 'Password');
        final loginFinder = find.widgetWithText(ElevatedButton, 'Login');

        expect(emailFinder, findsOneWidget);
        expect(passwordFinder, findsOneWidget);
        expect(loginFinder, findsOneWidget);
      });

      testWidgets('storing login token when app is re-run',
          (WidgetTester tester) async {
        dioAdapter.onGet('/notebooks').reply(200, notebooks);
        dioAdapter.onPost('/users/login').reply(200, {}, headers: {
          'set-cookie': ['Mock Token']
        });

        app.main();
        await tester.pumpAndSettle();

        final emailFinder = find.widgetWithText(TextField, 'Email Address');
        final passwordFinder = find.widgetWithText(TextField, 'Password');
        final loginFinder = find.widgetWithText(ElevatedButton, 'Login');

        // Enter email and password
        await tester.enterText(emailFinder, 'admin@example.com');
        await tester.enterText(passwordFinder, 'superSecret123!');

        // Submit form
        await tester.tap(loginFinder);
        await tester.pump(Duration(seconds: 1));

        // Confirm token is set
        expect(await _storage.read(key: 'aToken'), 'Mock Token');

        // Re-run app
        app.main();
        await tester.pumpAndSettle();

        // Confirm notebooks page is rendered
        expect(find.text('Notebook 1'), findsOneWidget);
        expect(find.text('Notebook 1 Summary'), findsOneWidget);

        expect(find.text('Notebook 2'), findsOneWidget);

        expect(find.text('Notebook 3'), findsOneWidget);
        expect(find.text('Notebook 3 Summary'), findsOneWidget);
      });
    });

    group('with stored token', () {
      testWidgets('confirm notebooks page is rendered',
          (WidgetTester tester) async {
        await _storage.write(key: 'aToken', value: 'Test Token');
        dioAdapter.onGet('/notebooks').reply(200, notebooks);

        app.main();
        await tester.pumpAndSettle();

        // Confirm cards are shown for each notebook
        expect(find.text('Notebook 1'), findsOneWidget);
        expect(find.text('Notebook 1 Summary'), findsOneWidget);

        expect(find.text('Notebook 2'), findsOneWidget);

        expect(find.text('Notebook 3'), findsOneWidget);
        expect(find.text('Notebook 3 Summary'), findsOneWidget);
      });
    });
  });
}
