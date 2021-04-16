import 'package:flutter/material.dart';
import 'package:app/screens/loginpage.dart';
// import 'package:http/http.dart' as http;
// import 'dart:async';
// import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prix banque',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(
        title: "Login to Prixbank"),
    );
  }
}
