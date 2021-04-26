import 'dart:convert';
import 'dart:io';

import 'package:app/models/bankAccount.dart';
import 'package:app/models/operation.dart';
import 'package:app/models/user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<BankAccount> getBankAccount(User userObj) async {
  var client = http.Client();
  try {
    var response = await client.get(
        Uri.https(
            env["URL_PROD"].toString(), "/users/" + userObj.email + "/banks"),
        headers: {HttpHeaders.authorizationHeader: "Bearer ${userObj.token}"});
    if (response.statusCode == 200) {
      List<BankAccount> bankAccounts;
      bankAccounts = (json.decode(response.body) as List)
          .map((i) => BankAccount.fromJson(i))
          .toList();
      return bankAccounts[0];
    } else {
      throw Exception('Can not retrieve account');
    }
  } finally {
    client.close();
  }
}

Future<List<Operation>> getOperations(User userObj) async {
  var client = http.Client();
  try {
    var response = await client.get(
        Uri.https(env["URL_PROD"].toString(),
            "/users/" + userObj.email + "/banks/1/operations"),
        headers: {HttpHeaders.authorizationHeader: "Bearer ${userObj.token}"});
    if (response.statusCode == 200) {
      List<Operation> operations;
      operations = (json.decode(response.body) as List)
          .map((i) => Operation.fromJson(i))
          .toList();
      operations = operations
          .where((x) =>
              x.transfer == true || (x.invoice == true && x.acquitted == true))
          .toList();
      operations.sort((a,b) => -a.createdAt.compareTo(b.createdAt));
      return operations;
    } else {
      throw Exception('Can not retrieve operation list');
    }
  } finally {
    client.close();
  }
}
