import 'package:app/components/AppDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:app/models/user.dart';
// import 'package:app/models/bankAccount.dart';

class TransferPage extends StatefulWidget {
  const TransferPage({Key? key}) : super(key: key);

  @override
  _TransferPageState createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark),
        child: Scaffold(
            drawer: AppDrawer(),
            appBar: AppBar(
                iconTheme: IconThemeData(
                  color: Colors.blue, //change your color here
                ),
                backgroundColor: Colors.white38,
                elevation: 0.0,
                title: Text(
                  "Transfer",
                  style: TextStyle(color: Colors.black),
                ),
                centerTitle: true),
            body: Center(
              child: Column(
                children: [
                  const SizedBox(height: 25),
                  Card(
                      elevation: 5,
                      child: Center(
                          child: InkWell(
                              splashColor: Colors.blue.withAlpha(30),
                              onTap: () {
                                print('Card tapped.');
                              },
                              child: const SizedBox(
                                  height: 100,
                                  child: Center(
                                    child: Text('Create a new transfer'),
                                  ))))),
                  Card(
                      elevation: 5,
                      child: Center(
                          child: InkWell(
                              splashColor: Colors.blue.withAlpha(30),
                              onTap: () {
                                print('Card tapped.');
                              },
                              child: const SizedBox(
                                  height: 100,
                                  child: Center(
                                    child: Text('Show all my transfer'),
                                  ))))),
                  const SizedBox(
                    height: 50,
                    child: Center(child: Text("Previous transfer")),
                  ),
                  Expanded(
                      child: ListTileTheme(
                          contentPadding: const EdgeInsets.all(10.0),
                          shape: ShapeBorder.lerp(null, null, 10),
                          child: ListView(
                              // children: snapshot.map((data) => _buildListItem(context, data)).toList()
                              children: [
                                ListTile(
                                    leading: Icon(Icons.check, color: Colors.green), title: Text("bonjour groupe")),
                                Divider(),

                                ListTile(
                                    leading: Icon(
                                      Icons.pending,
                                      color: Colors.blue,
                                    ),
                                    title: Text("bonjour groupe")),
                                Divider(),

                                ListTile(
                                    leading: Icon(
                                      Icons.error,
                                      color: Colors.red,
                                    ),
                                    title: Text("bonjour groupe")),
                                Divider(),

                                ListTile(
                                    leading: Icon(Icons.check, color: Colors.green), title: Text("bonjour groupe")),
                                Divider(),
                                ListTile(
                                    leading: Icon(Icons.check, color: Colors.green), title: Text("bonjour groupe")),
                                Divider(),

                                ListTile(
                                    leading: Icon(
                                      Icons.pending,
                                      color: Colors.blue,
                                    ),
                                    title: Text("bonjour groupe")),

                                Divider(),

                                ListTile(
                                    leading: Icon(Icons.check, color: Colors.green), title: Text("bonjour groupe")),

                                Divider(),
                                ListTile(
                                    leading: Icon(Icons.check, color: Colors.green), title: Text("bonjour groupe")),

                                //   ListTile(title: Text("Bonjour groupe")),
                                //  ListTile(title: Text("Bonjour groupe"))],
                              ])))
                ],
              ),
            )));
  }
}
