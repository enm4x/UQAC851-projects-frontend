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

Future<Operation> getOperation(User user, BankAccount bank) async {
  var client = http.Client();
  try {
    var response = await client.get(Uri.https(
        env["URL_PROD"].toString(),
        "/users/" +
            user.email.toString() +
            "/banks/" +
            bank.id.toString() +
            "/operations"));

    if (response.statusCode == 200) {
      return Operation.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Can not retrieve operation');
    }
  } finally {
    client.close();
  }
}
