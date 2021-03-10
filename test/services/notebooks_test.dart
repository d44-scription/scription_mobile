import 'package:test/test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:scription_mobile/services/notebook.service.dart';
import 'package:scription_mobile/http-common.dart';

void main() async {
  group('Notebook service', () {
    DioAdapter dioAdapter;

    final notebooks = [
      {'name': 'Notebook 1', 'summary': 'Test summary 1', 'id': 1},
      {'name': 'Notebook 2', 'summary': 'Test summary 2', 'id': 2}
    ];

    setUpAll(() {
      // Set up mock dio adapter before all tests
      dioAdapter = DioAdapter();

      Http().dio.httpClientAdapter = dioAdapter;
    });

    test('index', () async {
      // Data is returned correctly
      dioAdapter.onGet('/notebooks').reply(200, notebooks);

      final response = await NotebookService().index();

      expect(response, notebooks);
    });
  });
}
