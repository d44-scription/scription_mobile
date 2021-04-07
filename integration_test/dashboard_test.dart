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

  const String notableName = 'Test Notable Name';
  const String notableDescription = 'Test Notable Description';

  const String noteContent = 'Test Note Content';

  // Notebooks finders
  final notebookNameFinder = find.text(notebookName);

  // Dashboard finders
  final charactersFinder = find.text(Constants.CHARACTERS);
  final charactersSubtitleFinder =
      find.text('View characters for $notebookName');

  final itemsFinder = find.text(Constants.ITEMS);
  final itemsSubtitleFinder = find.text('View items for $notebookName');

  final locationsFinder = find.text(Constants.LOCATIONS);
  final locationsSubtitleFinder = find.text('View locations for $notebookName');

  final unlinkedFinder = find.text(Constants.UNLINKED_NOTES);
  final unlinkedSubtitleFinder =
      find.text('View unlinked notes for $notebookName');

  final recentsFinder = find.text(Constants.RECENTLY_ACCESSED);
  final recentsSubtitleFinder = find.text(Constants.RECENTLY_ACCESSED_NOTABLES);

  // Notables finders
  final notableNameFinder = find.text(notableName);
  final notableDescriptionFinder = find.text(notableDescription);

  // Note finders
  final noteContentFinder = find.text(noteContent);

  final notebooks = [
    {
      'id': 1,
      'name': notebookName,
      'summary': '',
    }
  ];

  final notables = [
    {
      'id': 2,
      'notebook_id': 1,
      'name': notableName,
      'description': notableDescription,
      'text_code': '',
    }
  ];

  final notes = [
    {
      'id': 3,
      'content': noteContent,
      'notebook_id': 1,
    }
  ];

  setUpAll(() async {
    // Set up mock dio adapter before all tests
    dioAdapter = DioAdapter();

    Http().dio.httpClientAdapter = dioAdapter;

    Http().aToken = 'Test Token';
    await _storage.write(key: 'aToken', value: 'Test Token');
  });

  group('dashboard', () {
    setUp(() {
      dioAdapter.onGet('/notebooks').reply(200, notebooks);
    });

    testWidgets('rendering correctly', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Confirm notebooks page is rendered
      expect(notebookNameFinder, findsOneWidget);

      // View notebook dashboard page
      await tester.tap(notebookNameFinder);
      await tester.pumpAndSettle();

      expect(charactersFinder, findsOneWidget);
      expect(charactersSubtitleFinder, findsOneWidget);

      expect(itemsFinder, findsOneWidget);
      expect(itemsSubtitleFinder, findsOneWidget);

      expect(locationsFinder, findsOneWidget);
      expect(locationsSubtitleFinder, findsOneWidget);

      expect(unlinkedFinder, findsOneWidget);
      expect(unlinkedSubtitleFinder, findsOneWidget);

      expect(recentsFinder, findsOneWidget);
      expect(recentsSubtitleFinder, findsOneWidget);
    });

    testWidgets('viewing characters', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // View notebook dashboard page
      await tester.tap(notebookNameFinder);
      await tester.pumpAndSettle();

      // View characters list
      dioAdapter.onGet('/notebooks/1/characters').reply(200, notables);
      await tester.tap(charactersFinder);
      await tester.pumpAndSettle();

      expect(notableNameFinder, findsOneWidget);
      expect(notableDescriptionFinder, findsOneWidget);
      expect(
          find.text('$notebookName | ${Constants.CHARACTERS}'), findsOneWidget);

      // View first character notes
      dioAdapter.onGet('/notebooks/1/notables/2/notes').reply(200, notes);
      await tester.tap(notableNameFinder);
      await tester.pumpAndSettle();

      expect(noteContentFinder, findsOneWidget);
      expect(find.text('$notableName | Notes'), findsOneWidget);

      // View first note
      await tester.tap(noteContentFinder);
      await tester.pumpAndSettle();

      expect(noteContentFinder, findsOneWidget);
      expect(find.text('Note'), findsOneWidget);
    });

    testWidgets('viewing items', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // View notebook dashboard page
      await tester.tap(notebookNameFinder);
      await tester.pumpAndSettle();

      // View items list
      dioAdapter.onGet('/notebooks/1/items').reply(200, notables);
      await tester.tap(itemsFinder);
      await tester.pumpAndSettle();

      expect(notableNameFinder, findsOneWidget);
      expect(notableDescriptionFinder, findsOneWidget);
      expect(find.text('$notebookName | ${Constants.ITEMS}'), findsOneWidget);

      // View first item notes
      dioAdapter.onGet('/notebooks/1/notables/2/notes').reply(200, notes);
      await tester.tap(notableNameFinder);
      await tester.pumpAndSettle();

      expect(noteContentFinder, findsOneWidget);
      expect(find.text('$notableName | Notes'), findsOneWidget);

      // View first note
      await tester.tap(noteContentFinder);
      await tester.pumpAndSettle();

      expect(noteContentFinder, findsOneWidget);
      expect(find.text('Note'), findsOneWidget);
    });

    testWidgets('viewing locations', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // View notebook dashboard page
      await tester.tap(notebookNameFinder);
      await tester.pumpAndSettle();

      // View locations list
      dioAdapter.onGet('/notebooks/1/locations').reply(200, notables);
      await tester.tap(locationsFinder);
      await tester.pumpAndSettle();

      expect(notableNameFinder, findsOneWidget);
      expect(notableDescriptionFinder, findsOneWidget);
      expect(find.text('$notebookName | ${Constants.LOCATIONS}'), findsOneWidget);

      // View first location notes
      dioAdapter.onGet('/notebooks/1/notables/2/notes').reply(200, notes);
      await tester.tap(notableNameFinder);
      await tester.pumpAndSettle();

      expect(noteContentFinder, findsOneWidget);
      expect(find.text('$notableName | Notes'), findsOneWidget);

      // View first note
      await tester.tap(noteContentFinder);
      await tester.pumpAndSettle();

      expect(noteContentFinder, findsOneWidget);
      expect(find.text('Note'), findsOneWidget);
    });

    testWidgets('viewing unlinked notes', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // View notebook dashboard page
      await tester.tap(notebookNameFinder);
      await tester.pumpAndSettle();

      // View unlinked notes list
      dioAdapter.onGet('/notebooks/1/notes/unlinked').reply(200, notes);
      await tester.tap(unlinkedFinder);
      await tester.pumpAndSettle();

      expect(noteContentFinder, findsOneWidget);
      expect(find.text('${Constants.UNLINKED} | Notes'), findsOneWidget);

      // View first note
      await tester.tap(noteContentFinder);
      await tester.pumpAndSettle();

      expect(noteContentFinder, findsOneWidget);
      expect(find.text('Note'), findsOneWidget);
    });

    // View recently accessed notables
    // View first notable notes
    // View first note
  });
}
