import 'package:flutter/material.dart';
import 'package:scription_mobile/notebooks/card.dart';
import 'package:scription_mobile/services/notebook.service.dart';
import 'package:scription_mobile/index.dart';

class Notebooks extends StatefulWidget {
  @override
  _NotebooksState createState() => _NotebooksState();
}

class _NotebooksState extends State<Notebooks> {
  @override
  Widget build(BuildContext context) {
    return Index(
        display: ({Map<String, dynamic> data}) {
          assert(data != null);
          return NotebookCard(data: data);
        },
        callback: NotebookService().index,
        title: 'Notebooks');
  }
}
