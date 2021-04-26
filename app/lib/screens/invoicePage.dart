import 'package:app/Tools/invoiceDataAccess.dart';
import 'package:app/components/AppDrawer.dart';
import 'package:app/components/InvoiceComponent.dart';
import 'package:app/models/invoice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app/models/user.dart';

import 'createInvoicePage.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({Key? key, required this.userObj}) : super(key: key);
  final User userObj;
  @override
  _InvoicePageState createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  late Future<List<Invoice>> invoices;
  // var userObj = new User(
  //     id: 1,
  //     email: "user1prixbanque@gmail.com",
  //     token:
  //         "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NTUxMTcxNjksIm5iZiI6MTYxOTExNzE2OSwidXNlcmlkIjoidXNlcjFwcml4YmFucXVlQGdtYWlsLmNvbSJ9.GZgurQ5LpUdQ2wM806l5r019DC73qrNUZg5DQkancZw",
  //     firstName: "User1",
  //     lastName: "Lambda",
  //     userAccount: 1);

  @override
  void initState() {
    super.initState();
    invoices = initInvoice();
  }

  Future<List<Invoice>> initInvoice() async {
<<<<<<< HEAD
    return await getInvoices(widget.userObj);
=======
    return await getPaidInvoices(userObj);
>>>>>>> 6187f11... update InvoicePage
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
                  "Invoice",
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) => CreateInvoicePage(userObj: widget.userObj)));
                              },
                              child: const SizedBox(
                                  height: 100,
                                  child: Center(
                                    child: Text('Create invoice'),
                                  ))))),
                  Expanded(
                      child: ListTileTheme(
                          contentPadding: const EdgeInsets.all(10.0),
                          shape: ShapeBorder.lerp(null, null, 10),
                          child: ListView(
                            children: [
                              ListTile(
                                leading: Icon(Icons.warning, color: Colors.red),
                                title: Text("Facture impayée"),
                                onTap: () {
                                  print("tapped");
                                },
                              ),
                              Divider(),
                              ListTile(
                                leading: Icon(
                                  Icons.check,
                                  color: Colors.green,
                                ),
                                title: Text("Facture Payée"),
                                onTap: () {
                                  print("tapped");
                                },
                              ),
                              Divider(),
                              const SizedBox(
                                height: 50,
                                child: Center(child: Text("Previous invoice")),
                              ),
                              FutureBuilder<List<Invoice>>(
                                future: invoices,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return displayInvoiceList(snapshot.data!);
                                  } else {
                                    return Text('No Recent Invoices');
                                  }
                                },
                              ),
                              Divider(),
                            ],
                          )))
                ],
              ),
            )));
  }
}
