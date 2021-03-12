import 'package:flutter/material.dart';
import 'package:scription_mobile/models/note.dart';
import 'package:scription_mobile/styles.dart';
import 'package:scription_mobile/text-helper.dart';

class NoteCard extends StatefulWidget {
  NoteCard({Key key, this.note}) : super(key: key);

  final Note note;

  @override
  _NoteCardState createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
          TextHelper.truncate(TextHelper.trimMentions(widget.note.content)),
          style: Styles.title()),
    );
  }
}
