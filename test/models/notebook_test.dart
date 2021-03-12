import 'package:test/test.dart';
import 'package:scription_mobile/models/notebook.dart';

void main() async {
  final json = {
    'id': 1,
    'name': 'Test Notebook',
    'summary': 'Test Summary',
  };

  group('Notebook model', () {
    test('generating from JSON', () async {
      Notebook notebook = Notebook.fromJson(json);

      expect(notebook.id, 1);
      expect(notebook.name, 'Test Notebook');
      expect(notebook.summary, 'Test Summary');
    });
  });
}
