class Notebook {
  final int id;
  final String name;
  final String summary;

  Notebook({this.id, this.name, this.summary});

  factory Notebook.fromJson(Map<String, dynamic> data) {
    return Notebook(
      id: data['id'],
      name: data['name'],
      summary: data['summary'],
    );
  }
}
