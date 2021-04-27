import 'package:app/Tools/InvoiceDataAccess.dart';
import 'package:app/components/InvoiceComponent.dart';
import 'package:app/models/invoice.dart';
import 'package:app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PendingInvoicePage extends StatefulWidget {
  const PendingInvoicePage({Key? key, required this.userObj}) : super(key: key);
  final User userObj;

  @override
  _PendingInvoicePage createState() => _PendingInvoicePage();
}

class _PendingInvoicePage extends State<PendingInvoicePage> {
  late Future<List<Invoice>> invoices;

  @override
  void initState() {
    super.initState();
    invoices = initInvoice();
  }

  Future<List<Invoice>> initInvoice() async {
    return await getPendingInvoices(widget.userObj);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.light),
      child: Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.blue, //change your color here
            ),
            backgroundColor: Colors.white38,
            elevation: 0.0,
            title: Text(
              "Pending Invoices",
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true),
        body: Column(
          children: <Widget>[
            FutureBuilder<List<Invoice>>(
              future: invoices,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data!.length);
                  return displayPendingInvoiceList(widget.userObj, snapshot.data!, context);
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

Container displayPendingInvoiceList(User userObj, List<Invoice> invoicesList, BuildContext context) {
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
            trailing: invoiceAmount(invoicesList, index),
            title: invoiceActor(invoicesList, index),
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
              Text('Would you like to cancel this invoice ?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Oui'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Non'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
