import 'package:flutter/material.dart';
import 'package:scription_mobile/notes/card.dart';
import 'package:scription_mobile/services/note.service.dart';
import 'package:scription_mobile/index.dart';

class Notes extends StatefulWidget {
  Notes({Key key, this.notebookId, this.notableId, this.notableName})
      : super(key: key);
  final int notebookId;
  final int notableId;
  final String notableName;

  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  Future<void> _callback() async {
    return NoteService().index(widget.notebookId, widget.notableId);
  }

  @override
  Widget build(BuildContext context) {
    return Index(
        display: ({Map<String, dynamic> data}) {
          assert(data != null);
          return NoteCard(data: data);
        },
        callback: _callback,
        title: '${widget.notableName} | Notes');
  }
}
