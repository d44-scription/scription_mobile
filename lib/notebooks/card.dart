import 'package:flutter/material.dart';
import 'package:scription_mobile/models/notebook.dart';

class NotebookCard extends StatefulWidget {
  NotebookCard({Key key, this.value}) : super(key: key);

  final Notebook value;

  @override
  _NotebookCardState createState() => _NotebookCardState();
}

class _NotebookCardState extends State<NotebookCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.amber[500],
      child: Center(child: Text(widget.value.name)),
    );
  }
}
