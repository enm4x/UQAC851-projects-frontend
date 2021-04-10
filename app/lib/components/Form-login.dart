import 'dart:async';

import 'package:flutter/material.dart';
import 'package:app/Tools/auth.dart';
import 'package:app/models/user.dart';
import 'package:app/screens/dashboard.dart';
import 'package:app/screens/signuppage.dart';

class FormLogin extends StatefulWidget {
  const FormLogin({Key? key, required this.userObj}) : super(key: key);
  final User userObj;

  @override
  _FormLoginWidgetState createState() => _FormLoginWidgetState();
}

// This is the private State class that goes with MyStatefulWidget.
class _FormLoginWidgetState extends State<FormLogin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailInputController = TextEditingController();
  final pwdInputController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailInputController.dispose();
    pwdInputController.dispose();
    super.dispose();
  }

  void updateUserToken(String tok) {
    widget.userObj.email = emailInputController.text;
    widget.userObj.token = tok;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: emailInputController,
                style: TextStyle(color: Color(0xFF2e3440)),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(20),
                    filled: true,
                    fillColor: Color(0xFFd8dee9),
                    border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0), borderSide: BorderSide.none),
                    hintStyle: TextStyle(color: Color(0xFF2e3440)),
                    hintText: "Email adress",
                    prefixIcon: Icon(
                      Icons.email,
                      color: Color(0xFF2e3440),
                    )),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: pwdInputController,
                obscureText: true,
                style: TextStyle(color: Color(0xFF2e3440)),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFd8dee9),
                    border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0), borderSide: BorderSide.none),
                    hintStyle: TextStyle(color: Color(0xFF2e3440)),
                    hintText: "Password",
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Color(0xFF2e3440),
                    )),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 50, vertical: 15))),
                  onPressed: () async {
                    final snackLoginError = SnackBar(
                      content: Text("Error while login"),
                      behavior: SnackBarBehavior.floating,
                    );
                    if (_formKey.currentState!.validate()) {
                      await userConnection(emailInputController.text, pwdInputController.text)
                          .then((value) => {
                                setState(() => {updateUserToken(value)}),
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => DashboardPage(userObj: widget.userObj)),
                                )
                              })
                          .catchError((e) {
                        print("Got error : $e");
                        ScaffoldMessenger.of(context).showSnackBar(snackLoginError);
                      });
                    }
                  },
                  child: const Text('Login'),
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignupPage(
                                  title: "Signin page",
                                  userObj: widget.userObj,
                                )));
                  },
                  child: Text("Click here to register"),
                  style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(Colors.white))),
            ],
          ),
        ));
  }
}
