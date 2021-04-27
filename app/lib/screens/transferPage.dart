//Default import
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//Component import
import 'package:app/components/AppDrawer.dart';
//Models import
import 'package:app/models/user.dart';
import 'package:app/models/transfer.dart';
//Tools import
import 'package:app/Tools/client_transfer.dart';
//Screens import
import 'package:app/screens/newTransferPage.dart';
import 'package:app/screens/transferDetails.dart';

class TransferPage extends StatefulWidget {
  const TransferPage({Key? key, required this.userObj}) : super(key: key);
  final User userObj;
  @override
  _TransferPageState createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  // var userInstance = new User(
  //     id: 2,
  //     email: "user2prixbanque@gmail.com",
  //     token:
  //         "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NTUyMzU2NTMsIm5iZiI6MTYxOTIzNTY1MywidXNlcmlkIjoidXNlcjJwcml4YmFucXVlQGdtYWlsLmNvbSJ9.DZ6Se65hai1w91hU0PCwC7-bVXZY8jidvETg0_RlEBs",
  //     firstName: "Eikichi",
  //     lastName: "Onizuka",
  //     userAccount: 2);

  late List<Transfer> userTransfer;

  Future<List<Transfer>> getTransferList() async {
    userTransfer = await getAllTransfers(widget.userObj);

    return userTransfer;
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark),
        child: Scaffold(
            drawer: AppDrawer(
              userObj: widget.userObj,
            ),
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
                                                  userObj: widget.userObj,
                                                ))),
                                  },
                              child: const SizedBox(
                                  height: 100,
                                  child: Center(
                                    child: Text('Create a new transfer'),
                                  ))))),
                  // Card(
                  //     elevation: 5,
                  //     child: Center(
                  //         child: InkWell(
                  //             splashColor: Colors.blue.withAlpha(30),
                  //             onTap: () {
                  //               print('Card tapped.');
                  //             },
                  //             child: const SizedBox(
                  //                 height: 100,
                  //                 child: Center(
                  //                   child: Text('Show all my transfer'),
                  //                 ))))),
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
                                    item?.from == widget.userObj.email ? Icons.upload_rounded : Icons.download_rounded,
                                    color: Colors.green,
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.more_vert),
                                    onPressed: () => {
                                      if (item != null)
                                        {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (BuildContext context) => TransferDetailPage(
                                                        transferData: item,
                                                        myUser: widget.userObj,
                                                      )))
                                        }
                                    },
                                  ),
                                  title: Text(item?.from == widget.userObj.email ? "${item?.to}" : "${item?.from}"),
                                  subtitle: Text("amount : ${item?.amount}"),
                                  onTap: () => {},
                                ),
                                Divider()
                              ]);
                            } else if (item != null && item.verificationTry < 3) {
                              return Column(children: [
                                ListTile(
                                  // contentPadding: EdgeInsets.only(left: 15),
                                  leading: Icon(
                                    item.to == widget.userObj.email ? Icons.download_rounded : Icons.upload_rounded,
                                    color: Colors.blue,
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.more_vert),
                                    onPressed: () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) => TransferDetailPage(
                                                    transferData: item,
                                                    myUser: widget.userObj,
                                                  )))
                                    },
                                  ),
                                  title: Text(item.from == widget.userObj.email ? "${item.to}" : "${item.from}"),
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
                                    item?.from == widget.userObj.email ? Icons.upload_rounded : Icons.download_rounded,
                                    color: Colors.red,
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.more_vert),
                                    onPressed: () => {
                                      if (item != null)
                                        {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (BuildContext context) => TransferDetailPage(
                                                        transferData: item,
                                                        myUser: widget.userObj,
                                                      )))
                                        }
                                    },
                                  ),
                                  title: Text(item?.from == widget.userObj.email ? "${item?.to}" : "${item?.from}"),
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
