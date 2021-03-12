import 'package:flutter/material.dart';
import 'package:scription_mobile/models/notable.dart';
import 'package:scription_mobile/styles.dart';
import 'package:scription_mobile/notes/index.dart';

class NotableCard extends StatefulWidget {
  NotableCard({Key key, this.notable}) : super(key: key);

  final Notable notable;

  @override
  _NotableCardState createState() => _NotableCardState();
}

class _NotableCardState extends State<NotableCard> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.notable.name, style: Styles.title()),
      subtitle: Text(widget.notable.description ?? '', style: Styles.body()),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Notes(
                    notableId: widget.notable.id,
                    notebookId: widget.notable.notebookId)));
      },
    );
  }
}
