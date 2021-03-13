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
    testWidgets('confirm login page is rendered when no login saved',
        (WidgetTester tester) async {
      await _storage.deleteAll();

      app.main();
      await tester.pumpAndSettle();

      final emailFinder = find.widgetWithText(TextField, 'Email Address');
      final passwordFinder = find.widgetWithText(TextField, 'Password');
      final loginFinder = find.widgetWithText(ElevatedButton, 'Login');

      expect(emailFinder, findsOneWidget);
      expect(passwordFinder, findsOneWidget);
      expect(loginFinder, findsOneWidget);
    });

    testWidgets('confirm notebooks page is rendered when login is saved',
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
}
