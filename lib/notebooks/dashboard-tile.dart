import 'package:flutter/material.dart';
import 'package:scription_mobile/styles.dart';

typedef Widget DisplayType();

class DashboardTile extends StatelessWidget {
  DashboardTile({Key key, this.icon, this.display, this.title, this.subtitle})
      : super(key: key);

  final IconData icon;
  final DisplayType display;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Icon(icon, size: 48, color: Styles.orangeAccent()),
        title: Text(title, style: Styles.subtitle()),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => display()));
        },
        subtitle: Text(subtitle));
  }
}
