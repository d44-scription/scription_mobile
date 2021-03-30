import 'package:flutter/material.dart';
import 'package:scription_mobile/notebooks/index.dart';
import 'package:scription_mobile/services/authentication.service.dart';
import 'package:scription_mobile/styles.dart';
import 'package:scription_mobile/constants.dart' as Constants;

class Login extends StatefulWidget {
  Login({Key key, this.message}) : super(key: key);
  final String message;

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
        Navigator.pushReplacement(
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
  void initState() {
    super.initState();

    if (widget.message != null) {
      new Future<Null>.delayed(Duration.zero, () {
        ScaffoldMessenger.of(context).showSnackBar(
          new SnackBar(content: new Text(widget.message)),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    return Scaffold(
        appBar: AppBar(title: Text(Constants.TITLE)),
        body: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: AutofillGroup(
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      validator: (value) {
                        return value.isEmpty ? Constants.ENTER_EMAIL : null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: [AutofillHints.email],
                      onEditingComplete: node.nextFocus,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          labelText: Constants.EMAIL,
                          icon:
                              Icon(Icons.alternate_email, color: Styles.orange()),
                          labelStyle: TextStyle(color: Colors.white60)),
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      autofillHints: [AutofillHints.password],
                      validator: (value) {
                        return value.isEmpty ? Constants.ENTER_PASSWORD : null;
                      },
                      onEditingComplete: _login,
                      decoration: InputDecoration(
                          labelText: Constants.PASSWORD,
                          icon: Icon(Icons.lock, color: Styles.orange()),
                          labelStyle: TextStyle(color: Colors.white60)),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 16, bottom: 16),
                        child: ElevatedButton(
                            onPressed: _isLoginDisabled ? null : _login,
                            child: Text(Constants.LOGIN),
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(200, 36)))),
                    Text(Constants.NO_ACCOUNT,
                        style: Styles.title(), textAlign: TextAlign.center),
                    Text(Constants.GET_STARTED,
                        style: Styles.body(), textAlign: TextAlign.center)
                  ],
                ),
              ),
            )));
  }
}
