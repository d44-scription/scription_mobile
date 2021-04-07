import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:scription_mobile/http-common.dart';
import 'package:scription_mobile/constants.dart' as Constants;

// The application under test.
import 'package:scription_mobile/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  final _storage = new FlutterSecureStorage();
  DioAdapter dioAdapter;

  const String notebookName = 'Test Notebook Name';
  const String notebookSummary = 'Test Notebook Summary';
  const String errorMessage = 'Test Error';

  final emailFinder = find.widgetWithText(TextField, Constants.EMAIL);
  final passwordFinder = find.widgetWithText(TextField, Constants.PASSWORD);
  final loginFinder = find.widgetWithText(ElevatedButton, Constants.LOGIN);
  final errorFinder = find.widgetWithText(SnackBar, errorMessage);

  final notebookFinder = find.text(notebookName);
  final summaryFinder = find.text(notebookSummary);

  final error = {'errors': errorMessage, 'statusCode': 422};
  final notebooks = [
    {
      'id': 1,
      'name': notebookName,
      'summary': notebookSummary,
    }
  ];

  setUpAll(() async {
    // Set up mock dio adapter before all tests
    dioAdapter = DioAdapter();

    Http().dio.httpClientAdapter = dioAdapter;
  });

  testWidgets('traversing app', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Confirm login page is rendered
    expect(emailFinder, findsOneWidget);
    expect(passwordFinder, findsOneWidget);
    expect(loginFinder, findsOneWidget);

    // Confirm stored token is removed
    expect(Http().aToken, '');
    expect(await _storage.read(key: 'aToken'), null);

    // Reject login
    dioAdapter.onPost('/users/login').reply(422, error);

    // Enter email and password
    await tester.enterText(emailFinder, 'admin@example.com');
    await tester.enterText(passwordFinder, 'superSecret123!');

    // Submit form
    await tester.tap(loginFinder);
    await tester.pumpAndSettle();

    // Confirm error is shown
    expect(errorFinder, findsOneWidget);

    // Accept login
    dioAdapter.onGet('/notebooks').reply(200, notebooks);
    dioAdapter.onPost('/users/login').reply(200, {}, headers: {
      'set-cookie': ['Mock Token']
    });

    // Submit form
    await tester.tap(loginFinder);
    await tester.pumpAndSettle();

    // Confirm notebooks page is rendered
    expect(notebookFinder, findsOneWidget);
    expect(summaryFinder, findsOneWidget);

    // View notebook dashboard page

    // View characters list
    // View first character notes
    // View first note
    // Return to dashboard

    // View items list
    // View first item notes
    // View first note
    // Return to dashboard

    // View locations list
    // View first location notes
    // View first note
    // Return to dashboard
    //
    // View unlinked notes list
    // View first note
    // Return to dashboard
    //
    // View recently accessed notables
    // View first notable notes
    // View first note
    //
    // Logout
    // Confirm we are on login page
  });
}
