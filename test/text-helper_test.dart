import 'package:test/test.dart';
import 'package:scription_mobile/text-helper.dart';

void main() async {
  final normalString = 'Test String';
  final longString = 'X' * 151;
  final mentionString =
      '@[Character 1](@1), #[Location 2](#2), and :[Item 3](:3)';

  group('Text helper', () {
    test('truncating string', () async {
      expect(TextHelper.truncate(normalString), normalString);
      expect(TextHelper.truncate(longString), '${'X' * 150}...');
      expect(TextHelper.truncate(mentionString), mentionString);
    });

    test('removing mentions from string', () async {
      expect(TextHelper.trimMentions(normalString), normalString);
      expect(TextHelper.trimMentions(longString), longString);
      expect(TextHelper.trimMentions(mentionString),
          'Character 1, Location 2, and Item 3');
    });
  });
}
