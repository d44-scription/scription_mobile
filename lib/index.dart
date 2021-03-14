import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:scription_mobile/styles.dart';
import 'package:scription_mobile/constants.dart' as Constants;

typedef Widget DisplayType({@required final Map<String, dynamic> data});

class Index extends StatefulWidget {
  Index({Key key, this.display, this.callback}) : super(key: key);

  final DisplayType display;
  final AsyncCallback callback;

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: widget.callback,
        child: FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.isEmpty) {
                  return Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(children: [
                        Text(Constants.NO_CONTENT, style: Styles.title()),
                        Divider(),
                        Text(Constants.VISIT_WEB_APP, style: Styles.body())
                      ]));
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) =>
                      this.widget.display(data: snapshot.data[index]),
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                );
              }
              return Center(child: CircularProgressIndicator());
            },
            future: widget.callback()));
  }
}
