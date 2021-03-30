import 'package:flutter/material.dart';
import 'package:scription_mobile/http-common.dart';
import 'package:scription_mobile/login.dart';
import 'package:scription_mobile/notebooks/index.dart';
import 'package:scription_mobile/services/authentication.service.dart';
import 'package:scription_mobile/styles.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scription',
      navigatorKey: Http().navigatorKey,
      theme: ThemeData(
        // Default theme styles
        primarySwatch: Styles.orange(),
        scaffoldBackgroundColor: Styles.grey(),
        canvasColor: Styles.grey(),
        textTheme: Theme.of(context)
            .textTheme
            .apply(bodyColor: Colors.white, displayColor: Colors.white),
        dividerColor: Styles.orangeAccent(),
        errorColor: Colors.red[200],
      ),
      home: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data ? Notebooks() : Login();
            }

            return Scaffold(body: CircularProgressIndicator());
          },
          future: AuthenticationService().isLoggedIn()),
    );
  }
}
