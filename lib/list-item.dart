import 'package:flutter/material.dart';

class ListItem extends StatefulWidget {
  final String text;

  const ListItem ({ Key key, this.text }): super(key: key);

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.text);
  }
}
