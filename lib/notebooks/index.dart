import 'package:flutter/material.dart';
import 'package:scription_mobile/notebooks/card.dart';
import 'package:scription_mobile/models/notebook.dart';
import 'package:scription_mobile/services/notebook.service.dart';
import 'package:scription_mobile/styles.dart';
import 'package:scription_mobile/constants.dart' as Constants;

class Notebooks extends StatefulWidget {
  @override
  _NotebooksState createState() => _NotebooksState();
}

class _NotebooksState extends State<Notebooks> {
  List<Notebook> _notebooks = [];
  bool _loading = true;

  Future<void> _getNotebooks() async {
    setState(() {
      _loading = true;
    });

    NotebookService().index().then((response) {
      List<Notebook> newList = [];

      for (Map<String, dynamic> data in response) {
        newList.add(Notebook.fromJson(data));
      }

      setState(() {
        _notebooks = newList;
        _loading = false;
      });
    });
  }

  Widget _renderList() {
    if (_loading) {
      return CircularProgressIndicator();
    } else if (!_loading && _notebooks.isEmpty) {
      return Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(children: [
            Text('No notebooks added!', style: Styles.title()),
            Divider(),
            Text(Constants.VISIT_WEB_APP, style: Styles.body())
          ]));
    } else {
      return ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: _notebooks.length,
        itemBuilder: (BuildContext context, int index) =>
            NotebookCard(notebook: _notebooks[index]),
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _getNotebooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: Text('Notebooks'), automaticallyImplyLeading: false),
        body: RefreshIndicator(
          child: Center(child: _renderList()),
          onRefresh: _getNotebooks,
        ));
  }
}
