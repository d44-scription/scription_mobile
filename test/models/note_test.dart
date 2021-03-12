import 'package:test/test.dart';
import 'package:scription_mobile/models/note.dart';

void main() async {
  final json = {
    'id': 1,
    'content': 'Test Note',
    'notebook_id': 2,
  };

  group('Note model', () {
    test('generating from JSON', () async {
      Note note = Note.fromJson(json);

      expect(note.id, 1);
      expect(note.content, 'Test Note');
      expect(note.notebookId, 2);
    });
  });
}
