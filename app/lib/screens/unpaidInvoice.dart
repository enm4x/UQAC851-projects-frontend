import 'package:app/Tools/InvoiceDataAccess.dart';
import 'package:app/components/InvoiceComponent.dart';
import 'package:app/models/invoice.dart';
import 'package:app/models/user.dart';
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
          body: Container(
            child: Column(
              children: <Widget>[
                FutureBuilder<List<Invoice>>(
                  future: invoices,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return displayInvoiceList(widget.userObj, snapshot.data!);
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
