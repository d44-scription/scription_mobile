class TextHelper {
  static String trimMentions(String string) {
    return string
        .replaceAll(new RegExp(r'[@:#]\['), '')
        .replaceAll(new RegExp(r'\]\([@:#]\d+\)'), '');
  }

  static String truncate(String string) {
    return (string.length <= 150) ? string : '${string.substring(0, 150)}...';
  }
}
