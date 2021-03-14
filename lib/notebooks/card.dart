import 'package:flutter/material.dart';
import 'package:scription_mobile/models/notebook.dart';
import 'package:scription_mobile/notebooks/dashboard.dart';
import 'package:scription_mobile/styles.dart';

class NotebookCard extends StatefulWidget {
  NotebookCard({Key key, this.data}) : super(key: key);

  final Map<String, dynamic> data;

  @override
  _NotebookCardState createState() => _NotebookCardState();
}

class _NotebookCardState extends State<NotebookCard> {
  @override
  Widget build(BuildContext context) {
    Notebook _notebook = Notebook.fromJson(widget.data);

    return ListTile(
      title: Text(_notebook.name, style: Styles.title()),
      subtitle: Text(_notebook.summary ?? '', style: Styles.body()),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Dashboard(notebook: _notebook)));
      },
    );
  }
}
