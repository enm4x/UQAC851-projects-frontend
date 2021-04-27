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
      throw Exception('Can not retrieve paid invoice');
    }
  } finally {
    client.close();
  }
}

Future<List<Invoice>> getUnpaidInvoices(User userObj) async {
  var client = http.Client();
  try {
    var response = await client.get(
        Uri.https(env["URL_PROD"].toString(), "/users/${userObj.email}/banks/${userObj.userAccount}/invoices"),
        headers: {HttpHeaders.authorizationHeader: "Bearer ${userObj.token}"});
    if (response.statusCode == 200) {
      List<Invoice> invoices;
      invoices = (json.decode(response.body) as List).map((i) => Invoice.fromJson(i)).toList();
      invoices = invoices
          .where((x) =>
              x.acquitted == false && x.senderId == userObj.id && DateTime.parse(x.dueDate).isAfter(DateTime.now()))
          .toList();
      invoices.sort((a, b) => a.dueDate.compareTo(b.dueDate));
      return invoices;
    } else {
      throw Exception('Can not retrieve unpaid invoice');
    }
  } finally {
    client.close();
  }
}

Future<List<Invoice>> getPendingInvoices(User userObj) async {
  var client = http.Client();
  try {
    var response = await client.get(
        Uri.https(env["URL_PROD"].toString(), "/users/${userObj.email}/banks/${userObj.userAccount}/invoices"),
        headers: {HttpHeaders.authorizationHeader: "Bearer ${userObj.token}"});
    if (response.statusCode == 200) {
      List<Invoice> invoices;
      invoices = (json.decode(response.body) as List).map((i) => Invoice.fromJson(i)).toList();
      invoices = invoices.where((x) => x.acquitted == false && x.receiverId == userObj.id).toList();
      invoices.sort((a, b) => -a.dueDate.compareTo(b.dueDate));
      return invoices;
    } else {
      throw Exception('Can not retrieve pending invoices');
    }
  } finally {
    client.close();
  }
}

Future<String> destroyInvoice(User userInfo, Invoice invoice) async {
  var client = http.Client();
  try {
    var response = await client.delete(
      Uri.https(
          env["URL_PROD"].toString(), "users/${userInfo.email}/banks/${userInfo.userAccount}/invoices/${invoice.id}"),
      headers: {HttpHeaders.authorizationHeader: "Bearer ${userInfo.token}"},
    );
    if (response.statusCode == 204) {
      return response.statusCode.toString();
    } else {
      throw Exception('Failed to delete');
    }
  } finally {
    client.close();
  }
}

Future<String> patchInvoice(User userInfo, Invoice invoice) async {
  var client = http.Client();
  try {
    var response = await client.patch(
        Uri.https(
            env["URL_PROD"].toString(), "users/${userInfo.email}/banks/${userInfo.userAccount}/invoices/${invoice.id}"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer ${userInfo.token}"
        },
        body: {
          'id': '${invoice.id}',
          'amount': '${invoice.amount}',
          'to': '${invoice.to}',
          'acquitted': 'true',
          'due_date': '${invoice.dueDate}',
        });
    if (response.statusCode == 204) {
      return response.statusCode.toString();
    } else {
      throw Exception('Failed to delete');
    }
  } finally {
    client.close();
  }
}
