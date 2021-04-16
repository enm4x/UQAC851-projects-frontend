import 'package:app/components/AppDrawer.dart';
import 'package:app/Tools/methods.dart';
import 'package:app/screens/StatementsPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(BalancePage());

class BalancePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light),
        child: Scaffold(
          drawer: AppDrawer(),
          appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.blue, //change your color here
              ),
              backgroundColor: Colors.white38,
              elevation: 0.0,
              title: Text(
                "Accounts",
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: true),
          body: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StatementsPage()),
              );
            },
            child: Container(
              color: Colors.grey,
              child: Column(
                children: <Widget>[
                  topArea(),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              print("user info");
            },
            backgroundColor: Color(0xFFd8dee9),
            child: Icon(
              Icons.add,
              color: Color(0xFF2e3440),
            ),
          ),
        ));
  }
}
