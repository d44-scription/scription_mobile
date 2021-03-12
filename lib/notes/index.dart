import 'package:flutter/material.dart';
import 'package:scription_mobile/notes/card.dart';
import 'package:scription_mobile/models/note.dart';
import 'package:scription_mobile/services/note.service.dart';
import 'package:scription_mobile/styles.dart';
import 'package:scription_mobile/constants.dart' as Constants;

class Notes extends StatefulWidget {
  Notes({Key key, this.notebookId, this.notableId}) : super(key: key);
  final int notebookId;
  final int notableId;

  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  List<Note> _notes = [];
  bool _loading = true;

  Future<void> _getNotes() async {
    setState(() {
      _loading = true;
    });

    NoteService().index(widget.notebookId, widget.notableId).then((response) {
      List<Note> newList = [];

      for (Map<String, dynamic> data in response) {
        newList.add(Note.fromJson(data));
      }

      setState(() {
        _notes = newList;
        _loading = false;
      });
    });
  }

  Widget _renderList() {
    if (_loading) {
      return CircularProgressIndicator();
    } else if (!_loading && _notes.isEmpty) {
      return Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(children: [
            Text('No notes added!', style: Styles.title()),
            Divider(),
            Text(Constants.VISIT_WEB_APP, style: Styles.body())
          ]));
    } else {
      return ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: _notes.length,
        itemBuilder: (BuildContext context, int index) =>
            NoteCard(note: _notes[index]),
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Notes')),
        body: RefreshIndicator(
          child: Center(child: _renderList()),
          onRefresh: _getNotes,
        ));
  }
}
