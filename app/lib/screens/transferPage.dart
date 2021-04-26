import 'package:app/components/AppDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app/screens/newTransferPage.dart';
import 'package:app/models/user.dart';
import 'package:app/models/transfer.dart';

import 'package:app/Tools/client_transfer.dart';

class TransferPage extends StatefulWidget {
  const TransferPage({Key? key}) : super(key: key);

  @override
  _TransferPageState createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  var userInstance = new User(
      id: 2,
      email: "user2prixbanque@gmail.com",
      token:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NTUyMzU2NTMsIm5iZiI6MTYxOTIzNTY1MywidXNlcmlkIjoidXNlcjJwcml4YmFucXVlQGdtYWlsLmNvbSJ9.DZ6Se65hai1w91hU0PCwC7-bVXZY8jidvETg0_RlEBs",
      firstName: "Eikichi",
      lastName: "Onizuka",
      userAccount: 2);

  late List<Transfer> userTransfer;

  void printUserData(User u) {
    print("User email --------: ${u.email}");
    print("User id -----------: ${u.id}");
    print("User bank account -: ${u.userAccount.toString()}");
  }

  void printTransferData(List<Transfer> lt) {
    for (var t in lt) {
      // print(" Transfer sent for ------------- : ${t.to}");
      // print(" Transfer amount is ------------ : ${t.amount}");
      // print(" Transfer verification status is : ${t.verified}");
      // print(" Transfer sent by -------------- : ${t.from}");
      print(" --------- Start ---------- \n");
      print(t.toString());
      // print(" Transfer sent by -------------- : ${t.from}");

      print(" ---------- end ----------- \n");
    }
  }

  Future<List<Transfer>> getTransferList() async {
    userTransfer = await getAllTransfers(userInstance);

    return userTransfer;
  }

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
                              onTap: () => {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) => NewTransferPage(
                                                  userObj: userInstance,
                                                ))),
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
                  FutureBuilder<List<Transfer>>(
                    future: getTransferList(),
                    builder: (BuildContext context, AsyncSnapshot<List<Transfer>> snapshot) {
                      if (snapshot.hasData) {
                        return Expanded(
                            child: ListTileTheme(
                                // contentPadding: const EdgeInsets.all(5.0),
                                // shape: ShapeBorder.lerp(null, null, 10),
                                child: ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            final item = snapshot.data?[index];

                            if (item?.verified == true) {
                              return Column(children: [
                                ListTile(
                                  // contentPadding: EdgeInsets.only(left: 15),
                                  leading: Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.more_vert),
                                    onPressed: () => {},
                                  ),
                                  title: Text("${item?.from}"),
                                  subtitle: Text("amount : ${item?.amount}"),
                                  onTap: () => {},
                                ),
                                Divider()
                              ]);
                            } else if (item != null && item.verificationTry <= 3) {
                              return Column(children: [
                                ListTile(
                                  // contentPadding: EdgeInsets.only(left: 15),
                                  leading: Icon(
                                    Icons.pending_actions,
                                    color: Colors.blue,
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.more_vert),
                                    onPressed: () => {},
                                  ),
                                  title: Text("${item.from}"),
                                  subtitle: Text("amount : ${item.amount}"),
                                  onTap: () => {},
                                ),
                                Divider()
                              ]);
                            } else {
                              return Column(children: [
                                ListTile(
                                  // contentPadding: EdgeInsets.only(left: 15),
                                  leading: Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.more_vert),
                                    onPressed: () => {},
                                  ),
                                  title: Text("${item?.from}"),
                                  subtitle: Text("amount : ${item?.amount}"),
                                  onTap: () => {},
                                ),
                                Divider()
                              ]);
                            }
                          },
                        )));
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ],
              ),
            )));
  }
}
