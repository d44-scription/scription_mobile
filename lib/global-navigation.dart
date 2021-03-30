import 'package:flutter/material.dart';
import 'package:scription_mobile/login.dart';
import 'package:scription_mobile/notebooks/index.dart';
import 'package:scription_mobile/services/authentication.service.dart';
import 'package:scription_mobile/styles.dart';
import 'package:scription_mobile/constants.dart' as Constants;

class GlobalNavigation extends StatefulWidget {
  GlobalNavigation({Key key, this.body, this.title}) : super(key: key);
  final Widget body;
  final String title;

  @override
  _GlobalNavigationState createState() => _GlobalNavigationState();
}

class _GlobalNavigationState extends State<GlobalNavigation> {
  Widget _buildScaffold() {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title ?? 'Index')),
        drawer: Drawer(
            child: ListView(
          padding: EdgeInsets.all(0),
          children: <Widget>[
            DrawerHeader(
              child: Text(Constants.TITLE, style: Styles.darkHeader()),
              decoration: BoxDecoration(
                color: Styles.orange(),
              ),
            ),
            ListTile(
              leading: Icon(Icons.auto_stories,
                  size: 36, color: Styles.orangeAccent()),
              title: Text('Notebooks', style: Styles.note()),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Notebooks()),
                    (route) => false);
              },
            ),
            ListTile(
              leading:
                  Icon(Icons.logout, size: 36, color: Styles.orangeAccent()),
              title: Text(Constants.LOGOUT, style: Styles.note()),
              onTap: () {
                AuthenticationService().logout();

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Login(message: Constants.LOGGED_OUT)),
                    (route) => false);
              },
            ),
          ],
        )),
        body: widget.body);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data ? _buildScaffold() : Login();
          }

          return CircularProgressIndicator();
        },
        future: AuthenticationService().isLoggedIn());
  }
}
