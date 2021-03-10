import 'package:flutter/material.dart';
import 'package:scription_mobile/models/notebook.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key, this.notebook}) : super(key: key);

  final Notebook notebook;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.notebook.name)),
        body: Center(
            child: Column(
          children: [Text(widget.notebook.summary ?? '')],
        )));
  }
}
