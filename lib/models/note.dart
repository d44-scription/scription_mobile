class Note {
  final int id;
  final String content;
  final int notebookId;

  Note({this.id, this.content, this.notebookId});

  factory Note.fromJson(Map<String, dynamic> data) {
    return Note(
      id: data['id'],
      content: data['content'],
      notebookId: data['notebook_id'],
    );
  }
}
