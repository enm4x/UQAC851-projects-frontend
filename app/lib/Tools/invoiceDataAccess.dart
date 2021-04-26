import 'dart:convert';
import 'dart:io';

import 'package:app/models/invoice.dart';
import 'package:app/models/user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<String> createInvoice(User userObj, InvoiceToSend invoice) async {
  final response = await http.post(
    Uri.https(env["URL_PROD"].toString(), "/users/${userObj.email}/banks/${userObj.userAccount}/operations/invoices"),
    headers: {HttpHeaders.authorizationHeader: "Bearer ${userObj.token}"},
    body: {
      'amount': '${invoice.amount}',
      'to': '${invoice.to}',
      'due_date': '${invoice.dueDate}',
    },
  );
  print(response.statusCode);
  return response.statusCode.toString();
}

Future<List<Invoice>> getPaidInvoices(User userObj) async {
  var client = http.Client();
  try {
    var response = await client.get(
        Uri.https(env["URL_PROD"].toString(), "/users/${userObj.email}/banks/${userObj.userAccount}/invoices"),
        headers: {HttpHeaders.authorizationHeader: "Bearer ${userObj.token}"});
    if (response.statusCode == 200) {
      List<Invoice> invoices;
      invoices = (json.decode(response.body) as List).map((i) => Invoice.fromJson(i)).toList();
      invoices = invoices.where((x) => x.acquitted == true).toList();
      invoices.sort((a, b) => -a.createdAt.compareTo(b.createdAt));
      return invoices;
    } else {
      throw Exception('Can not retrieve operation list');
    }
  } finally {
    client.close();
  }
}
