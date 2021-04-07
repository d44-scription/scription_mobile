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
                    DashboardTile(
                        icon: Icons.home,
                        title: Constants.LOCATIONS,
                        subtitle: 'View locations for ${widget.notebook.name}',
                        display: () {
                          return Notables(
                              type: Constants.LOCATIONS,
                              notebookId: widget.notebook.id,
                              notebookName: widget.notebook.name);
                        }),
                    DashboardTile(
                        icon: Icons.hardware,
                        title: Constants.ITEMS,
                        subtitle: 'View items for ${widget.notebook.name}',
                        display: () {
                          return Notables(
                              type: Constants.ITEMS,
                              notebookId: widget.notebook.id,
                              notebookName: widget.notebook.name);
                        }),
                    DashboardTile(
                        icon: Icons.description,
                        title: Constants.UNLINKED_NOTES,
                        subtitle:
                            'View unlinked notes for ${widget.notebook.name}',
                        display: () {
                          return Notes(
                              notebookId: widget.notebook.id,
                              notableName: Constants.UNLINKED);
                        }),
                    DashboardTile(
                        icon: Icons.history,
                        title: Constants.RECENTLY_ACCESSED,
                        subtitle: 'Recently accessed notables',
                        display: () {
                          return Notables(
                              type: Constants.RECENTS,
                              notebookId: widget.notebook.id,
                              notebookName: widget.notebook.name);
                        }),
                  ],
                ))));
  }
}
