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

  final emailFinder = find.widgetWithText(TextField, Constants.EMAIL);
  final passwordFinder = find.widgetWithText(TextField, Constants.PASSWORD);
  final loginFinder = find.widgetWithText(ElevatedButton, Constants.LOGIN);

  final notebookFinder = find.text('Test Notebook');
  final summaryFinder = find.text('Test Summary');

  final drawerFinder = find.byTooltip('Open navigation menu');
  final notebooksFinder = find.text('Notebooks');
  final logoutFinder = find.text('Logout');

  final charactersFinder = find.text('Characters');
  final locationsFinder = find.text('Locations');
  final itemsFinder = find.text('Items');

  final notebooks = [
    {
      'id': 1,
      'name': 'Test Notebook',
      'summary': 'Test Summary',
    }
  ];

  final error = {'errors': 'Test Error Message'};

  setUpAll(() {
    // Set up mock dio adapter before all tests
    dioAdapter = DioAdapter();

    Http().dio.httpClientAdapter = dioAdapter;
  });

  group('login page', () {
    group('with no stored token', () {
      setUp(() async {
        Http().aToken = '';
        await _storage.deleteAll();
      });

      testWidgets('renders login page', (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle();

        // Confirm login page is rendered
        expect(emailFinder, findsOneWidget);
        expect(passwordFinder, findsOneWidget);
        expect(loginFinder, findsOneWidget);

        // Confirm notebooks page is not rendered
        expect(notebookFinder, findsNWidgets(0));
        expect(summaryFinder, findsNWidgets(0));

        // Confirm stored token is removed
        expect(Http().aToken, '');
        expect(await _storage.read(key: 'aToken'), null);
      });

      testWidgets('storing login token when app is re-run',
          (WidgetTester tester) async {
        dioAdapter.onGet('/notebooks').reply(200, notebooks);
        dioAdapter.onPost('/users/login').reply(200, {}, headers: {
          'set-cookie': ['Mock Token']
        });

        app.main();
        await tester.pumpAndSettle();

        // Confirm login page is rendered
        expect(emailFinder, findsOneWidget);
        expect(passwordFinder, findsOneWidget);
        expect(loginFinder, findsOneWidget);

        // Confirm notebooks page is not rendered
        expect(notebookFinder, findsNWidgets(0));
        expect(summaryFinder, findsNWidgets(0));

        // Enter email and password
        await tester.enterText(emailFinder, 'admin@example.com');
        await tester.enterText(passwordFinder, 'superSecret123!');

        // Submit form
        await tester.tap(loginFinder);
        await tester.pumpAndSettle();

        // Confirm token is set
        expect(await _storage.read(key: 'aToken'), 'Mock Token');

        dioAdapter.onGet('/notebooks').reply(200, notebooks);

        // Re-run app
        app.main();
        await tester.pumpAndSettle();

        // Confirm notebooks page is rendered
        expect(notebookFinder, findsOneWidget);
        expect(summaryFinder, findsOneWidget);

        // Confirm login page is not rendered
        expect(emailFinder, findsNWidgets(0));
        expect(passwordFinder, findsNWidgets(0));
        expect(loginFinder, findsNWidgets(0));
      });
    });

    group('with stored token', () {
      setUp(() async {
        Http().aToken = 'Test Token';
        await _storage.write(key: 'aToken', value: 'Test Token');
      });

      testWidgets('confirm notebooks page is rendered',
          (WidgetTester tester) async {
        dioAdapter.onGet('/notebooks').reply(200, notebooks);

        app.main();
        await tester.pumpAndSettle();

        // Confirm token is saved
        expect(Http().aToken, 'Test Token');
        expect(await _storage.read(key: 'aToken'), 'Test Token');

        // Confirm notebooks page is rendered
        expect(notebookFinder, findsOneWidget);
        expect(summaryFinder, findsOneWidget);

        // Confirm login page is not rendered
        expect(emailFinder, findsNWidgets(0));
        expect(passwordFinder, findsNWidgets(0));
        expect(loginFinder, findsNWidgets(0));
      });

      testWidgets('logging out', (WidgetTester tester) async {
        dioAdapter.onGet('/notebooks').reply(200, notebooks);

        app.main();
        await tester.pumpAndSettle();

        // Confirm token is saved
        expect(Http().aToken, 'Test Token');
        expect(await _storage.read(key: 'aToken'), 'Test Token');

        // Confirm notebooks page is rendered
        expect(notebookFinder, findsOneWidget);
        expect(summaryFinder, findsOneWidget);

        // Confirm login page is not rendered
        expect(emailFinder, findsNWidgets(0));
        expect(passwordFinder, findsNWidgets(0));
        expect(loginFinder, findsNWidgets(0));
        expect(logoutFinder, findsNWidgets(0));

        // Tap drawer sandwich icon
        await tester.tap(drawerFinder);
        await tester.pumpAndSettle();

        // Confirm drawer is rendered
        expect(notebooksFinder, findsNWidgets(2));
        expect(logoutFinder, findsOneWidget);

        // Tap logout button
        await tester.tap(logoutFinder);
        await tester.pumpAndSettle();

        // Confirm login page is rendered
        expect(emailFinder, findsOneWidget);
        expect(passwordFinder, findsOneWidget);
        expect(loginFinder, findsOneWidget);

        // Confirm notebooks page is not rendered
        expect(notebookFinder, findsNWidgets(0));
        expect(summaryFinder, findsNWidgets(0));

        // Confirm stored token is removed
        expect(Http().aToken, '');
        expect(await _storage.read(key: 'aToken'), null);
      });

      testWidgets('navigation', (WidgetTester tester) async {
        dioAdapter.onGet('/notebooks').reply(200, notebooks);

        app.main();
        await tester.pumpAndSettle();

        // Confirm token is saved
        expect(Http().aToken, 'Test Token');
        expect(await _storage.read(key: 'aToken'), 'Test Token');

        // Confirm notebooks page is rendered
        expect(notebookFinder, findsOneWidget);
        expect(summaryFinder, findsOneWidget);

        // Confirm dashboard page is not rendered
        expect(charactersFinder, findsNWidgets(0));
        expect(locationsFinder, findsNWidgets(0));
        expect(itemsFinder, findsNWidgets(0));

        // Tap notebook list item
        await tester.tap(notebookFinder);
        await tester.pumpAndSettle();

        // Confirm dashboard page is rendered
        expect(notebookFinder, findsOneWidget);
        expect(summaryFinder, findsOneWidget);
        expect(charactersFinder, findsOneWidget);
        expect(locationsFinder, findsOneWidget);
        expect(itemsFinder, findsOneWidget);

        // Tap drawer sandwich icon
        await tester.tap(drawerFinder);
        await tester.pumpAndSettle();

        // Confirm drawer is rendered
        expect(notebooksFinder, findsOneWidget);
        expect(logoutFinder, findsOneWidget);

        dioAdapter.onGet('/notebooks').reply(200, notebooks);

        // Tap notebooks button
        await tester.tap(notebooksFinder);
        await tester.pumpAndSettle();

        // Confirm notebooks page is rendered
        expect(notebookFinder, findsOneWidget);
        expect(summaryFinder, findsOneWidget);

        // Confirm dashboard page is not rendered
        expect(charactersFinder, findsNWidgets(0));
        expect(locationsFinder, findsNWidgets(0));
        expect(itemsFinder, findsNWidgets(0));

        // Confirm stored token is unchanged
        expect(Http().aToken, 'Test Token');
        expect(await _storage.read(key: 'aToken'), 'Test Token');
      });

      testWidgets('when request is unauthorised', (WidgetTester tester) async {
        dioAdapter.onGet('/notebooks').reply(401, []);

        app.main();
        await tester.pumpAndSettle();

        // Confirm login page is rendered
        expect(emailFinder, findsOneWidget);
        expect(passwordFinder, findsOneWidget);
        expect(loginFinder, findsOneWidget);

        // Confirm notebooks page is not rendered
        expect(notebookFinder, findsNWidgets(0));
        expect(summaryFinder, findsNWidgets(0));

        // Confirm stored token is removed
        expect(Http().aToken, '');
        expect(await _storage.read(key: 'aToken'), null);
      });
    });
  });
}
