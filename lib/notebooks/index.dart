import 'package:flutter/material.dart';
import 'package:scription_mobile/notebooks/card.dart';
import 'package:scription_mobile/models/notebook.dart';
import 'package:scription_mobile/services/notebook.service.dart';

class Notebooks extends StatefulWidget {
  @override
  _NotebooksState createState() => _NotebooksState();
}

Notebook n = Notebook(id: 1, name: "Notebook", summary: "n1");

class _NotebooksState extends State<Notebooks> {
  final List<Notebook> items = <Notebook>[n, n, n, n, n, n];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Notebooks index'), automaticallyImplyLeading: false),
      body: Center(
          child: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return NotebookCard(value: items[index]);
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      )),
    );
  }
}
