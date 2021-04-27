import 'package:app/Tools/InvoiceDataAccess.dart';
import 'package:app/models/invoice.dart';
import 'package:app/models/user.dart';
import 'package:flutter/material.dart';

Container displayInvoiceList(User userObj, List<Invoice> invoicesList) {
  if (invoicesList.length >= 6) {
    return Container(child: Column(children: <Widget>[for (var i = 0; i < 6; i++) invoiceItems(userObj, invoicesList, i)]));
  } else {
    return new Container(
        child: Column(children: <Widget>[
      for (var i = 0; i < invoicesList.length; i++) invoiceItems(userObj, invoicesList, i),
    ]));
  }
}

Container displayPendingInvoiceList(User userObj, List<Invoice> invoicesList) {
  if (invoicesList.length >= 6) {
    return Container(child: Column(children: <Widget>[for (var i = 0; i < 6; i++) invoiceItems(userObj, invoicesList, i)]));
  } else {
    return new Container(
        child: Column(children: <Widget>[
      for (var i = 0; i < invoicesList.length; i++) invoiceItems(userObj, invoicesList, i),
    ]));
  }
}

Container invoiceItems(User userObj, List<Invoice> invoicesList, int index, {Color oddColour = Colors.white}) {
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
          onTap: () => { patchInvoice(userObj, invoicesList[index])},
        ),
      ],
    ),
  );
}

Text invoiceActor(List<Invoice> invoicesList, int index) {
  if (invoicesList[index].receiverId == 1) {
    return Text("from " + invoicesList[index].from, style: TextStyle(fontSize: 16.0));
  } else {
    return Text("to " + invoicesList[index].to, style: TextStyle(fontSize: 16.0));
  }
}

Text invoiceAmount(List<Invoice> invoicesList, int index) {
  if (invoicesList[index].receiverId == 1) {
    return Text(r"+ $" + invoicesList[index].amount.toString(), style: TextStyle(fontSize: 16.0));
  } else {
    return Text(r"- $" + invoicesList[index].amount.toString(), style: TextStyle(fontSize: 16.0));
  }
}

Text invoiceDate(List<Invoice> invoicesList, int index) {
  return Text(invoicesList[index].createdAt, style: TextStyle(color: Colors.grey, fontSize: 14.0));
}

Text invoiceType(List<Invoice> invoicesList, int index) {
  if (invoicesList[index].invoice == true) {
    return Text("invoice", style: TextStyle(color: Colors.grey, fontSize: 14.0));
  } else {
    return Text("transfer", style: TextStyle(color: Colors.grey, fontSize: 14.0));
  }
}
