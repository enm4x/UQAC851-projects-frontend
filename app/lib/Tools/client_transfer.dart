import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:app/models/user.dart';
import 'package:app/models/transfer.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<List<Transfer>> getAllTransfers(User userCredentials) async {
  var client = http.Client();
  try {
    var response = await client.get(
      Uri.https(
          env["URL_PROD"].toString(), "users/${userCredentials.email}/banks/${userCredentials.userAccount}/transfers"),
      headers: {HttpHeaders.authorizationHeader: "Bearer ${userCredentials.token}"},
    );
    if (response.statusCode == 200) {
      List<Transfer> userTransfer;
      userTransfer = (json.decode(response.body) as List).map((i) => Transfer.fromJson(i)).toList();
      userTransfer.sort((a, b) => -a.createdAt.compareTo(b.createdAt));

      return userTransfer;
    } else {
      throw Exception('Failed to log-in');
    }
  } finally {
    client.close();
  }
}

Future<String> sendTransfer(User userInfo, TransferToSend newTransfer) async {
  var client = http.Client();

  try {
    var response = await client.post(
      Uri.https(env["URL_PROD"].toString(), "users/${userInfo.email}/banks/${userInfo.userAccount}/transfers"),
      headers: {HttpHeaders.authorizationHeader: "Bearer ${userInfo.token}"},
      body: {
        'to': '${newTransfer.to}',
        'amount': '${newTransfer.amount}',
        'scheduled': '${newTransfer.scheduled}',
        'instant': '${newTransfer.instant}',
        'date': '${newTransfer.date}',
        'question': '${newTransfer.question}',
        'answer': '${newTransfer.answer}',
      },
    );

    if (response.statusCode == 201) {
      return response.statusCode.toString();
    } else {
      throw Exception('Failed to log-in');
    }
  } finally {
    client.close();
  }
}

Future<String> verifyTransfer(User userInfo, Transfer newTransfer, String secAnswer) async {
  var client = http.Client();
  print(
      "@ : ${userInfo.email} , usr_acc : ${userInfo.userAccount} , tx_id :  ${newTransfer.id}, sec_ans : $secAnswer, ");
  try {
    var response = await client.get(
      Uri.https(env["URL_PROD"].toString(),
          "users/${userInfo.email}/banks/${userInfo.userAccount}/transfers/${newTransfer.id}/verify/$secAnswer"),
      headers: {HttpHeaders.authorizationHeader: "Bearer ${userInfo.token}"},
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 204) {
      return response.statusCode.toString();
    } else if (response.statusCode == 400) {
      throw Exception('400');
    } else {
      throw Exception('Failed to verify');
    }
  } finally {
    client.close();
  }
}

Future<String> destroyTransfer(User userInfo, Transfer newTransfer) async {
  var client = http.Client();

  try {
    var response = await client.delete(
      Uri.https(env["URL_PROD"].toString(),
          "users/${userInfo.email}/banks/${userInfo.userAccount}/transfers/${newTransfer.id}"),
      headers: {HttpHeaders.authorizationHeader: "Bearer ${userInfo.token}"},
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 204) {
      return response.statusCode.toString();
    } else {
      throw Exception('Failed to delete');
    }
  } finally {
    client.close();
  }
}
