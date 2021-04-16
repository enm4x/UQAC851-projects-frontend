import 'package:flutter/material.dart';
import 'package:app/components/bottombar.dart';
import 'package:app/Tools/methods.dart';
import 'package:flutter/services.dart';

class StatementsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light),
        child: Scaffold(
          appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.blue, //change your color here
              ),
              backgroundColor: Colors.white38,
              elevation: 0.0,
              title: Text(
                "Statements",
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: true),
          body: Container(
            color: Colors.grey,
            child: Column(
              children: <Widget>[
                displayAccoutList()
              ],
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
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomBar(),
        ));
  }
}
