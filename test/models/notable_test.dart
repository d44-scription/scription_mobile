import 'package:test/test.dart';
import 'package:scription_mobile/models/notable.dart';

void main() async {
  final json = {
    'id': 1,
    'notebook_id': 2,
    'name': 'Test Notable',
    'description': 'Test Description',
    'text_code': '@[Test Notable](@1)'
  };

  group('Notable model', () {
    test('generating from JSON', () async {
      Notable notable = Notable.fromJson(json);

      expect(notable.id, 1);
      expect(notable.notebookId, 2);
      expect(notable.name, 'Test Notable');
      expect(notable.description, 'Test Description');
      expect(notable.textCode, '@[Test Notable](@1)');
    });
  });
}
