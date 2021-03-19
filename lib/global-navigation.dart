import 'package:flutter/material.dart';
import 'package:scription_mobile/login.dart';
import 'package:scription_mobile/services/authentication.service.dart';
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
              leading: Icon(Icons.logout, size: 36, color: Colors.orange),
              title: Text('Logout', style: Styles.note()),
              onTap: () {
                AuthenticationService().logout();

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                    (route) => false);
              },
            ),
          ],
        )),
        body: widget.body);
  }
}
