import 'package:app/models/invoice.dart';
import 'package:flutter/material.dart';

import 'package:app/models/user.dart';

Text invoiceActor(List<Invoice> invoicesList, int index, User userObj) {
  if (invoicesList[index].to == userObj.email) {
    return Text("from : " + invoicesList[index].from, style: TextStyle(fontSize: 16.0));
  } else {
    return Text("to : " + invoicesList[index].to, style: TextStyle(fontSize: 16.0));
  }
}

Text invoiceAmount(List<Invoice> invoicesList, int index, User userObj) {
  if (invoicesList[index].to == userObj.email) {
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
