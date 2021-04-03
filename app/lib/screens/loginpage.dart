import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app/components/Form-login.dart';
import 'package:app/models/user.dart';

// import 'package:http/http.dart' as http;
// import 'dart:async';
// import 'dart:convert';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var currentUser = new User(id: 0, email: "", token: "", firstName: "", lastName: "");

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark),
        child: Scaffold(
          backgroundColor: Color(0xFF2e3440),
          body: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[FormLogin(userObj: currentUser)],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              print("user info \n@: ${currentUser.email} \ntoken : ${currentUser.token}");
            },
            child: const Icon(Icons.info),
            backgroundColor: Colors.green,
          ),
        ));
  }
}
