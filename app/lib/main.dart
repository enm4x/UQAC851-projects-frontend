import 'package:flutter/material.dart';
import 'package:app/screens/loginpage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as Dotenv;
// import 'package:http/http.dart' as http;
// import 'dart:async';
// import 'dart:convert';

void main() async {
  await Dotenv.load(fileName: ".env");
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
