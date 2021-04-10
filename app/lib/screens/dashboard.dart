import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app/components/bottombar.dart';
import 'package:app/models/user.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key, required this.userObj}) : super(key: key);
  final User userObj;

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
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
                children: <Widget>[Text("Welcome ${widget.userObj.firstName}")],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              print("user info \n@: ${widget.userObj.email} \ntoken : ${widget.userObj.token}");
            },
            backgroundColor: Color(0xFFd8dee9),
            child: Icon(
              Icons.add,
              color: Color(0xFF2e3440),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomBar(),
        ));
  }
}
