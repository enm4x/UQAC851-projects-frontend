import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6.0,
        color: Colors.transparent,
        elevation: 9.0,
        clipBehavior: Clip.antiAlias,
        child: Container(
            height: 50.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
                color: Color(0xFFd8dee9)),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Container(
                  height: 50.0,
                  width: MediaQuery.of(context).size.width / 2 - 40.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Icon(Icons.home, color: Color(0xFF2e3440)),
                      Icon(Icons.person_outline, color: Color(0xFF2e3440))
                    ],
                  )),
              Container(
                  height: 50.0,
                  width: MediaQuery.of(context).size.width / 2 - 40.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Icon(Icons.settings, color: Color(0xFF2e3440)),
                      Icon(Icons.help, color: Color(0xFF2e3440))
                    ],
                  )),
            ])));
  }
}
