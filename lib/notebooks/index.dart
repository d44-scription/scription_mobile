import 'package:flutter/material.dart';
import 'package:scription_mobile/notebooks/card.dart';
import 'package:scription_mobile/models/notebook.dart';
import 'package:scription_mobile/services/notebook.service.dart';

class Notebooks extends StatefulWidget {
  @override
  _NotebooksState createState() => _NotebooksState();
}

class _NotebooksState extends State<Notebooks> {
  List<Notebook> _notebooks = [];

  _getNotebooks() async {
    NotebookService().index().then((response) {
      List<Notebook> newList = [];

      for (Map<String, dynamic> data in response) {
        newList.add(Notebook.fromJson(data));
      }

      setState(() {
        _notebooks = newList;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getNotebooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Notebooks index'), automaticallyImplyLeading: false),
      body: Center(
          child: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: _notebooks.length,
        itemBuilder: (BuildContext context, int index) {
          return NotebookCard(value: _notebooks[index]);
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      )),
    );
  }
}
