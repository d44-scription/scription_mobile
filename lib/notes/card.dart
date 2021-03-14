import 'package:flutter/material.dart';
import 'package:scription_mobile/models/note.dart';
import 'package:scription_mobile/styles.dart';
import 'package:scription_mobile/text-helper.dart';
import 'package:scription_mobile/notes/show.dart';

class NoteCard extends StatefulWidget {
  NoteCard({Key key, this.data}) : super(key: key);

  final Map<String, dynamic> data;

  @override
  _NoteCardState createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  @override
  Widget build(BuildContext context) {
    Note _note = Note.fromJson(widget.data);

    return ListTile(
      subtitle: Text(
          TextHelper.truncate(TextHelper.trimMentions(_note.content)),
          style: Styles.note()),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Show(note: _note)));
      },
    );
  }
}
