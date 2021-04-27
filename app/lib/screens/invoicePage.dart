import 'package:app/Tools/invoiceDataAccess.dart';
import 'package:app/components/AppDrawer.dart';
import 'package:app/components/InvoiceComponent.dart';
import 'package:app/models/invoice.dart';
import 'package:app/screens/pendingInvoicePage.dart';
import 'package:app/screens/unpaidInvoice.dart';
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

  @override
  void initState() {
    super.initState();
    invoices = initInvoice();
  }

  Future<List<Invoice>> initInvoice() async {
    return await getPaidInvoices(widget.userObj);
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => UnpaidInvoicePage(userObj: widget.userObj)),
                                  );
                                },
                              ),
                              Divider(),
                              ListTile(
                                leading: Icon(
                                  Icons.check,
                                  color: Colors.green,
                                ),
                                title: Text("Facture en Attente"),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PendingInvoicePage(userObj: widget.userObj)),
                                  );
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
                                    return displayInvoiceList(widget.userObj, snapshot.data!, context);
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

  Container displayInvoiceList(User userObj, List<Invoice> invoicesList, BuildContext context) {
    if (invoicesList.length >= 6) {
      return Container(
          child:
              Column(children: <Widget>[for (var i = 0; i < 6; i++) invoiceItems(userObj, invoicesList, i, context)]));
    } else {
      return new Container(
          child: Column(children: <Widget>[
        for (var i = 0; i < invoicesList.length; i++) invoiceItems(userObj, invoicesList, i, context),
      ]));
    }
  }
}

Container invoiceItems(User userObj, List<Invoice> invoicesList, int index, BuildContext context,
    {Color oddColour = Colors.white}) {
  return Container(
    decoration: BoxDecoration(color: oddColour),
    padding: EdgeInsets.only(top: 21.8, bottom: 21.8, left: 5.0, right: 5.0),
    child: Column(
      children: <Widget>[
        ListTile(
          // contentPadding: EdgeInsets.only(left: 15),
          leading: Icon(
            Icons.upload_rounded,
            color: Colors.green,
          ),
          trailing: invoiceAmount(invoicesList, index),
          title: invoiceActor(invoicesList, index),
          subtitle: invoiceDate(invoicesList, index),
        )
      ],
    ),
  );
}
