import 'package:flutter/material.dart';
import 'package:scription_mobile/services/notable.service.dart';
import 'package:scription_mobile/notables/card.dart';
import 'package:scription_mobile/index.dart';

class Notables extends StatefulWidget {
  Notables({Key key, this.type, this.notebookId, this.notebookName}) : super(key: key);
  final String type;
  final int notebookId;
  final String notebookName;

  @override
  _NotablesState createState() => _NotablesState();
}

class _NotablesState extends State<Notables> {
  Future<void> _callback() async {
    return NotableService().index(widget.notebookId, widget.type);
  }

  @override
  Widget build(BuildContext context) {
    return Index(
        display: ({Map<String, dynamic> data}) {
          assert(data != null);
          return NotableCard(data: data);
        },
        callback: _callback,
        title: '${widget.notebookName} | ${widget.type}');
  }
}
