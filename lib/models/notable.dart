class Notable {
  final int id;
  final int notebookId;
  final String name;
  final String description;
  final String textCode;

  Notable(
      {this.id, this.notebookId, this.name, this.description, this.textCode});

  factory Notable.fromJson(Map<String, dynamic> data) {
    return Notable(
      id: data['id'],
      notebookId: data['notebook_id'],
      name: data['name'],
      description: data['description'],
      textCode: data['text_code'],
    );
  }
}
