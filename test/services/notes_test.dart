import 'package:test/test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:scription_mobile/services/note.service.dart';
import 'package:scription_mobile/http-common.dart';

void main() async {
  group('Note service', () {
    DioAdapter dioAdapter;

    final notebookId = 1;
    final notableId = 2;

    final notes = [
      {'content': 'Note 1 Content', 'id': 1},
      {'content': 'Note 2 Content', 'id': 2}
    ];

    setUpAll(() {
      // Set up mock dio adapter before all tests
      dioAdapter = DioAdapter();

      Http().dio.httpClientAdapter = dioAdapter;
    });

    group('index', () {
      test('when given notable id', () async {
        // Retrieves notes for given notable
        dioAdapter
            .onGet('/notebooks/$notebookId/notables/$notableId/notes')
            .reply(200, notes);

        final response = await NoteService().index(notebookId, notableId);

        expect(response, notes);
      });

      test('when not given notable id', () async {
        // Retrieves unlinked notes for given notebook
        dioAdapter
            .onGet('/notebooks/$notebookId/notes/unlinked')
            .reply(200, notes);

        final response = await NoteService().index(notebookId, null);

        expect(response, notes);
      });
    });
  });
}
