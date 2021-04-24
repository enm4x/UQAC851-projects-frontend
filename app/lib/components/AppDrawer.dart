import 'package:flutter/material.dart';
import 'package:app/screens/transferPage.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListTileTheme(
      selectedColor: Color(0xFF015FFF),
      contentPadding: EdgeInsets.all(20),
      child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: TextButton.icon(
                icon: Icon(
                  Icons.arrow_back,
                  color: Color(0xFF015FFF),
                ),
                onPressed: () => {Navigator.pop(context)},
                label: Text("Back", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.0, color: Colors.black)),
              ),
            ),
            ListTile(
                leading: Icon(Icons.account_balance),
                title: Text('Account'),
                selected: true,
                onTap: () {
                  // Update the state of the app.
                  // ...
                }),
            Divider(),
            ListTile(
                leading: Icon(Icons.receipt),
                title: Text('Statements'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                }),
            Divider(),
            ListTile(
                leading: Icon(Icons.compare_arrows),
                title: Text('Transfer'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TransferPage()));
                }),
            Divider(),
            ListTile(
                leading: Icon(Icons.attach_money),
                title: Text('Invoice'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                }),
          ]),
    ));
  }
}
