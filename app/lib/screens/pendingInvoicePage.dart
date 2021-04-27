import 'package:app/Tools/InvoiceDataAccess.dart';
import 'package:app/components/InvoiceComponent.dart';
import 'package:app/models/invoice.dart';
import 'package:app/models/user.dart';
import 'package:app/screens/invoicePage.dart';
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
          body: Container(
            child: Column(
              children: <Widget>[
                FutureBuilder<List<Invoice>>(
                  future: invoices,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.length >= 6) {
                        return Container(
                            child: Column(children: <Widget>[
                          for (var i = 0; i < 6; i++) invoiceItems(widget.userObj, snapshot.data!, i)
                        ]));
                      } else {
                        return new Container(
                            child: Column(children: <Widget>[
                          for (var i = 0; i < snapshot.data!.length; i++)
                            GestureDetector(
                              child: invoiceItems(widget.userObj, snapshot.data!, i),
                              onTap: () =>
                                  {patchInvoice(widget.userObj, snapshot.data![i]), Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => InvoicePage()))},
                            ),
                        ]));
                      }
                    } else {
                      return Expanded(child: Center(child: CircularProgressIndicator()));
                    }
                  },
                )
              ],
            ),
          ),
        ));
  }
}
