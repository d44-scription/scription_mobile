import 'package:flutter/material.dart';
import 'package:scription_mobile/models/notable.dart';
import 'package:scription_mobile/styles.dart';

class NotableCard extends StatefulWidget {
  NotableCard({Key key, this.notable}) : super(key: key);

  final Notable notable;

  @override
  _NotableCardState createState() => _NotableCardState();
}

class _NotableCardState extends State<NotableCard> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.notable.name);
  }
}
