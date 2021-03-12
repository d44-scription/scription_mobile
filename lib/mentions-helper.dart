class MentionsHelper {
  static String trimMentions(String string) {
    return string
        .replaceAll(new RegExp(r'[@:#]\['), '')
        .replaceAll(new RegExp(r'\]\([@:#]\d+\)'), '');
  }
}
