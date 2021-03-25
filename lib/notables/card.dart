import 'package:flutter/material.dart';
import 'package:scription_mobile/models/notable.dart';
import 'package:scription_mobile/styles.dart';
import 'package:scription_mobile/notes/index.dart';
import 'package:scription_mobile/text-helper.dart';

class NotableCard extends StatefulWidget {
  NotableCard({Key key, this.data}) : super(key: key);

  final Map<String, dynamic> data;

  @override
  _NotableCardState createState() => _NotableCardState();
}

class _NotableCardState extends State<NotableCard> {
  @override
  Widget build(BuildContext context) {
    Notable _notable = Notable.fromJson(widget.data);

    return ListTile(
      title: Text(_notable.name, style: Styles.title()),
      subtitle: Text(
          TextHelper.truncate(
              TextHelper.trimMentions(_notable.description ?? '')),
          style: Styles.body()),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Notes(
                    notableId: _notable.id,
                    notebookId: _notable.notebookId,
                    notableName: _notable.name)));
      },
    );
  }
}
