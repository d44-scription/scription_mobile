import 'package:flutter/material.dart';
import 'package:scription_mobile/login.dart';
import 'package:scription_mobile/notebooks/index.dart';
import 'package:scription_mobile/services/authentication.service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scription',
      theme: ThemeData(
        // Default theme styles
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Colors.grey[800],
        textTheme: Theme.of(context)
            .textTheme
            .apply(bodyColor: Colors.white, displayColor: Colors.white),
        dividerColor: Colors.orangeAccent,
        errorColor: Colors.red[200],
      ),
      home: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data ? Notebooks() : Login();
            }

            return CircularProgressIndicator();
          },
          future: AuthenticationService().isLoggedIn()),
    );
  }
}
