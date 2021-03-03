import 'package:flutter/material.dart';
import 'package:scription_mobile/http-common.dart';
import 'package:scription_mobile/list-item.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // Default theme styles
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Colors.grey[700],
      ),
      home: Home(title: 'Scription'),
    );
  }
}

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                Http().login().then((value) => {});
              },
              child: Text('Login'),
            ),
            RaisedButton(
              onPressed: () {
                Http().getNotebooks().then((value) => {});
              },
              child: Text('Get Notebooks'),
            ),
            ListItem(text: "Hello world")
          ],
        ),
      ),
    );
  }
}
