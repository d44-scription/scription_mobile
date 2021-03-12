import 'package:flutter/material.dart';
import 'package:scription_mobile/models/note.dart';
import 'package:scription_mobile/styles.dart';
import 'package:scription_mobile/text-helper.dart';

class Show extends StatefulWidget {
  Show({Key key, this.note}) : super(key: key);
  final Note note;

  @override
  _ShowState createState() => _ShowState();
}

class _ShowState extends State<Show> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Note')),
      body: Padding(
          padding: EdgeInsets.all(24),
          child: Text(TextHelper.trimMentions(widget.note.content),
              style: Styles.note())),
    );
  }
}
