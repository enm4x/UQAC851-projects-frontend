import 'package:app/models/invoice.dart';
import 'package:flutter/material.dart';

Container displayInvoiceList(List<Invoice> invoicesList) {
  if (invoicesList.length >= 6) {
    return Container(
        child: Column(children: <Widget>[
      for (var i = 0; i < 6; i++)
          invoiceItems(invoicesList, i)
        ]));
  } else {
    return new Container(
        child: Column(children: <Widget>[
      for (var i = 0; i < invoicesList.length; i++)
        invoiceItems(invoicesList, i),
    ]));
  }
}

Container invoiceItems(List<Invoice> invoicesList, int index,
    {Color oddColour = Colors.white}) {
  return Container(
    decoration: BoxDecoration(color: oddColour),
    padding: EdgeInsets.only(top: 21.8, bottom: 21.8, left: 5.0, right: 5.0),
    child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            invoiceActor(invoicesList, index),
            invoiceAmount(invoicesList, index)
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            invoiceDate(invoicesList, index),
            invoiceType(invoicesList, index),
          ],
        ),
      ],
    ),
  );
}

Text invoiceActor(List<Invoice> invoicesList, int index) {
  if (invoicesList[index].receiverId == 1) {
    return Text("from " + invoicesList[index].from,
        style: TextStyle(fontSize: 16.0));
  } else {
    return Text("to " + invoicesList[index].to,
        style: TextStyle(fontSize: 16.0));
  }
}

Text invoiceAmount(List<Invoice> invoicesList, int index) {
  if (invoicesList[index].receiverId == 1) {
    return Text(r"+ $" + invoicesList[index].amount.toString(),
        style: TextStyle(fontSize: 16.0));
  } else {
    return Text(r"- $" + invoicesList[index].amount.toString(),
        style: TextStyle(fontSize: 16.0));
  }
}

Text invoiceDate(List<Invoice> invoicesList, int index) {
  return Text(invoicesList[index].createdAt,
      style: TextStyle(color: Colors.grey, fontSize: 14.0));
}

Text invoiceType(List<Invoice> invoicesList, int index) {
  if (invoicesList[index].invoice == true) {
    return Text("invoice",
        style: TextStyle(color: Colors.grey, fontSize: 14.0));
  } else {
    return Text("transfer",
        style: TextStyle(color: Colors.grey, fontSize: 14.0));
  }
}
