import 'package:flutter/material.dart';
import 'package:scription_mobile/models/notebook.dart';
import 'package:scription_mobile/notebooks/dashboard.dart';

class NotebookCard extends StatefulWidget {
  NotebookCard({Key key, this.notebook}) : super(key: key);

  final Notebook notebook;

  @override
  _NotebookCardState createState() => _NotebookCardState();
}

class _NotebookCardState extends State<NotebookCard> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.notebook.name),
      subtitle: Text(widget.notebook.summary ?? ''),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Dashboard(notebook: widget.notebook)));
      },
    );
  }
}
