import 'package:app/Tools/invoiceDataAccess.dart';
import 'package:app/components/InvoiceComponent.dart';
import 'package:app/models/invoice.dart';
import 'package:app/models/user.dart';
import 'package:app/screens/invoicePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UnpaidInvoicePage extends StatefulWidget {
  const UnpaidInvoicePage({Key? key, required this.userObj}) : super(key: key);
  final User userObj;

  @override
  _UnpaidInvoicePage createState() => _UnpaidInvoicePage();
}

class _UnpaidInvoicePage extends State<UnpaidInvoicePage> {
  late Future<List<Invoice>> invoices;

  @override
  void initState() {
    super.initState();
    invoices = initInvoice();
  }

  Future<List<Invoice>> initInvoice() async {
    return await getUnpaidInvoices(widget.userObj);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark),
      child: Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.blue, //change your color here
            ),
            backgroundColor: Colors.white38,
            elevation: 0.0,
            title: Text(
              "Unpaid Invoices",
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true),
        body: Column(
          children: <Widget>[
            FutureBuilder<List<Invoice>>(
              future: invoices,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return displayUnpaidInvoiceList(widget.userObj, snapshot.data!, context);
                } else {
                  return Expanded(child: Center(child: CircularProgressIndicator()));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

Container displayUnpaidInvoiceList(User userObj, List<Invoice> invoicesList, BuildContext context) {
  if (invoicesList.length >= 6) {
    return Container(
        child: Column(children: <Widget>[for (var i = 0; i < 6; i++) invoiceItems(userObj, invoicesList, i, context)]));
  } else {
    return new Container(
        child: Column(children: <Widget>[
      for (var i = 0; i < invoicesList.length; i++) invoiceItems(userObj, invoicesList, i, context),
    ]));
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
            trailing: invoiceAmount(invoicesList, index, userObj),
            title: invoiceActor(invoicesList, index, userObj),
            subtitle: invoiceDate(invoicesList, index),
            onTap: () => {_showMyDialog(userObj, 890, invoicesList, index, context)}),
      ],
    ),
  );
}

Future<void> _showMyDialog(
    User userObj, int balance, List<Invoice> invoicesList, int index, BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirmation'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('balance : ' + balance.toString()),
              Text('Would you like to pay this invoice ?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Yes'),
            onPressed: () {
              patchInvoice(userObj, invoicesList[index]).then((value) => Navigator.push(
                  context, MaterialPageRoute(builder: (BuildContext context) => InvoicePage(userObj: userObj))));
            },
          ),
          TextButton(
            child: Text('NON'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
