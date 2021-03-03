import 'package:flutter/material.dart';
import 'package:scription_mobile/http-common.dart';
import 'package:scription_mobile/notebooks.dart';

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
  bool _isLoginDisabled = false;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _login() {
    // If local validations pass...
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoginDisabled = true;
      });

      // If serverside validations pass...
      Http().login(emailController.text, passwordController.text).then((value) {
        // Navigate to notebooks view
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Notebooks()));
      }).catchError((error) {
        final snackBar = SnackBar(content: Text(error.response.data["errors"]));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });

      setState(() {
        _isLoginDisabled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: emailController,
              validator: (value) {
                return value.isEmpty ? 'Please enter an email' : null;
              },
              decoration: const InputDecoration(
                  labelText: "Email Address",
                  icon: Icon(Icons.alternate_email)),
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              validator: (value) {
                return value.isEmpty ? 'Please enter a password' : null;
              },
              decoration: const InputDecoration(
                  labelText: "Password", icon: Icon(Icons.lock)),
            ),
            ElevatedButton(
              onPressed: _isLoginDisabled ? null : _login,
              child: Text('Login'),
            ),
          ],
        ),
      )),
    );
  }
}
