import 'package:flutter/material.dart';
import 'package:scription_mobile/models/notable.dart';
import 'package:scription_mobile/services/notable.service.dart';
import 'package:scription_mobile/styles.dart';
import 'package:scription_mobile/notables/card.dart';
import 'package:scription_mobile/constants.dart' as Constants;

class Notables extends StatefulWidget {
  Notables({Key key, this.type, this.notebookId}) : super(key: key);
  final String type;
  final int notebookId;

  @override
  _NotablesState createState() => _NotablesState();
}

class _NotablesState extends State<Notables> {
  List<Notable> _notables = [];
  bool _loading = true;

  Future<void> _getNotables() async {
    setState(() {
      _loading = true;
    });

    NotableService().index(widget.notebookId, widget.type).then((response) {
      List<Notable> newList = [];

      for (Map<String, dynamic> data in response) {
        newList.add(Notable.fromJson(data));
      }

      setState(() {
        _notables = newList;
        _loading = false;
      });
    });
  }

  Widget _renderList() {
    if (_loading) {
      return CircularProgressIndicator();
    } else if (!_loading && _notables.isEmpty) {
      return Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(children: [
            Text('No ${widget.type.toLowerCase()} added!', style: Styles.title()),
            Divider(),
            Text(Constants.VISIT_WEB_APP, style: Styles.body())
          ]));
    } else {
      return ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: _notables.length,
        itemBuilder: (BuildContext context, int index) =>
            NotableCard(notable: _notables[index]),
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _getNotables();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.type)),
        body: RefreshIndicator(
          child: Center(child: _renderList()),
          onRefresh: _getNotables,
        ));
  }
}
