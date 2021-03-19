import 'package:flutter/material.dart';
import 'package:scription_mobile/styles.dart';

class GlobalNavigation extends StatefulWidget {
  GlobalNavigation({Key key, this.body, this.title}) : super(key: key);
  final Widget body;
  final String title;

  @override
  _GlobalNavigationState createState() => _GlobalNavigationState();
}

class _GlobalNavigationState extends State<GlobalNavigation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title ?? 'Index')),
        drawer: Drawer(
            child: ListView(
          padding: EdgeInsets.all(0),
          children: <Widget>[
            DrawerHeader(
              child: Text('Scription', style: Styles.darkHeader()),
              decoration: BoxDecoration(
                color: Colors.orange,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        )),
        body: widget.body);
  }
}
