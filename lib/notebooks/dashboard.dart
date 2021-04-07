import 'package:flutter/material.dart';
import 'package:scription_mobile/global-navigation.dart';
import 'package:scription_mobile/models/notebook.dart';
import 'package:scription_mobile/notes/index.dart';
import 'package:scription_mobile/styles.dart';
import 'package:scription_mobile/notables/index.dart';
import 'package:scription_mobile/constants.dart' as Constants;
import 'package:scription_mobile/notebooks/dashboard-tile.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key, this.notebook}) : super(key: key);

  final Notebook notebook;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return GlobalNavigation(
        title: widget.notebook.name,
        body: Center(
            child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(widget.notebook.summary ?? '', style: Styles.body()),
                    DashboardTile(
                        icon: Icons.person,
                        title: Constants.CHARACTERS,
                        subtitle: 'View characters for ${widget.notebook.name}',
                        display: () {
                          return Notables(
                              type: Constants.CHARACTERS,
                              notebookId: widget.notebook.id,
                              notebookName: widget.notebook.name);
                        }),
                    ListTile(
                        leading: Icon(Icons.home,
                            size: 48, color: Styles.orangeAccent()),
                        title:
                            Text(Constants.LOCATIONS, style: Styles.subtitle()),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Notables(
                                      type: Constants.LOCATIONS,
                                      notebookId: widget.notebook.id,
                                      notebookName: widget.notebook.name)));
                        },
                        subtitle:
                            Text('View locations for ${widget.notebook.name}')),
                    ListTile(
                        leading: Icon(Icons.hardware,
                            size: 48, color: Styles.orangeAccent()),
                        title: Text(Constants.ITEMS, style: Styles.subtitle()),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Notables(
                                      type: Constants.ITEMS,
                                      notebookId: widget.notebook.id,
                                      notebookName: widget.notebook.name)));
                        },
                        subtitle:
                            Text('View items for ${widget.notebook.name}')),
                    ListTile(
                        leading: Icon(Icons.description,
                            size: 48, color: Styles.orangeAccent()),
                        title: Text('Unlinked Notes', style: Styles.subtitle()),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Notes(
                                      notebookId: widget.notebook.id,
                                      notableName: Constants.UNLINKED)));
                        },
                        subtitle: Text(
                            'View unlinked notes for ${widget.notebook.name}')),
                    ListTile(
                        leading: Icon(Icons.history,
                            size: 48, color: Styles.orangeAccent()),
                        title: Text(Constants.RECENTLY_ACCESSED,
                            style: Styles.subtitle()),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Notables(
                                      type: Constants.RECENTS,
                                      notebookId: widget.notebook.id,
                                      notebookName: widget.notebook.name)));
                        },
                        subtitle: Text('Recently accessed notables')),
                  ],
                ))));
  }
}
