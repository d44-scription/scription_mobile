import 'package:flutter/material.dart';
import 'package:scription_mobile/notebooks/index.dart';
import 'package:scription_mobile/services/authentication.service.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
      AuthenticationService()
          .login(emailController.text, passwordController.text)
          .then((value) {
        // Navigate to notebooks view
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Notebooks()));

        setState(() {
          _isLoginDisabled = false;
        });
      }).catchError((error) {
        final snackBar = SnackBar(content: Text(error.response.data['errors']));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        setState(() {
          _isLoginDisabled = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Scription')),
        body: Padding(
          padding: EdgeInsets.all(16),
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
                      labelText: 'Email Address',
                      icon: Icon(Icons.alternate_email, color: Colors.orange),
                      labelStyle: TextStyle(color: Colors.white60)),
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
                      labelText: 'Password',
                      icon: Icon(Icons.lock, color: Colors.orange),
                      labelStyle: TextStyle(color: Colors.white60)),
                ),
                ElevatedButton(
                  onPressed: _isLoginDisabled ? null : _login,
                  child: Text('Login'),
                ),
              ],
            ),
          ),
        ));
  }
}
