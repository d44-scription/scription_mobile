import 'package:test/test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:scription_mobile/services/notable.service.dart';
import 'package:scription_mobile/http-common.dart';

void main() async {
  group('Notable service', () {
    DioAdapter dioAdapter;

    final notebookId = 1;
    final type = "TestType";

    final notables = [
      {'name': 'Notable 1', 'summary': 'Test summary 1', 'id': 1},
      {'name': 'Notable 2', 'summary': 'Test summary 2', 'id': 2}
    ];

    setUpAll(() {
      // Set up mock dio adapter before all tests
      dioAdapter = DioAdapter();

      Http().dio.httpClientAdapter = dioAdapter;
    });

    test('index', () async {
      // Data is returned correctly
      dioAdapter
          .onGet('/notebooks/$notebookId/${type.toLowerCase()}')
          .reply(200, notables);

      final response = await NotableService().index(notebookId, type);

      expect(response, notables);
    });
  });
}
