import 'package:flutter/material.dart';
import 'package:scription_mobile/services/notebook.service.dart';

class Notebooks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notebooks index'),
      ),
      body: Center(
          child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              // Navigate back to first route when tapped.
              Navigator.pop(context);
            },
            child: Text('Go back!'),
          ),
          ElevatedButton(
            onPressed: () {
              NotebookService().index().then((value) => {});
            },
            child: Text('Get Notebooks'),
          ),
        ],
      )),
    );
  }
}
