import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:app/models/user.dart';
import 'package:app/models/bankAccount.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<String> userConnection(String userCredentials, String userPassword) async {
  var client = http.Client();
  final Digest pwdHash = hashPassword(userPassword);
  try {
    var response = await client.post(Uri.https(env["URL_PROD"].toString(), "/auth/login"),
        body: {'email': '$userCredentials', 'password': '${pwdHash.toString()}'});
    if (response.statusCode == 200) {
      Map res = jsonDecode(response.body);
      return res['token'];
    } else {
      throw Exception('Failed to log-in');
    }
  } finally {
    client.close();
  }
}

Future<String> userRegistration(User userInstance, String userPassword) async {
  var client = http.Client();
  final Digest pwdHash = hashPassword(userPassword);
  try {
    var response = await client.post(Uri.https(env["URL_PROD"].toString(), "/auth/register"), body: {
      'email': '${userInstance.email}',
      'first_name': '${userInstance.firstName}',
      'last_name': '${userInstance.lastName}',
      'password': '${pwdHash.toString()}'
    });

    if (response.statusCode == 201) {
      return response.statusCode.toString();
    } else {
      throw Exception('Failed to register');
    }
  } finally {
    client.close();
  }
}

Future<int> getUserInfo(User userObj) async {
  var client = http.Client();
  try {
    var response = await client.get(
      Uri.https(env["URL_PROD"].toString(), "/users/${userObj.email}"),
      headers: {HttpHeaders.authorizationHeader: "Bearer ${userObj.token}"},
    );
    if (response.statusCode == 200) {
      Map res = jsonDecode(response.body);
      return res['id'];
    } else {
      throw Exception('Can not retrieve user informations');
    }
  } finally {
    client.close();
  }
}

Future<bool> sendUseraccountVerification(User userObj, String emailToken) async {
  var client = http.Client();
  try {
    var response = await client.get(Uri.https(env["URL_PROD"].toString(), "/users/${userObj.email}/verify/$emailToken"),
        headers: {HttpHeaders.authorizationHeader: "Bearer ${userObj.token}"});

    if (response.statusCode == 204) {
      return true;
    } else {
      throw Exception('Failed to verify email');
    }
  } finally {
    client.close();
  }
}

Future<bool> isUserEmailVerified(User userObj) async {
  var client = http.Client();
  try {
    var response = await client.get(
      Uri.https(env["URL_PROD"].toString(), "/users/${userObj.email}"),
      headers: {HttpHeaders.authorizationHeader: "Bearer ${userObj.token}"},
    );
    if (response.statusCode == 200) {
      Map res = jsonDecode(response.body);

      if (res['verified'] == true) {
        return true;
      }
    } else {
      throw Exception('Failed to update user info');
    }
  } finally {
    client.close();
  }
  return false;
}

Future<String> updateUserInfo(User userObj) async {
  var client = http.Client();
  try {
    var response = await client.patch(Uri.https(env["URL_PROD"].toString(), "/users/${userObj.email}"),
        headers: {HttpHeaders.authorizationHeader: "Bearer ${userObj.token}"},
        body: {'email': '${userObj.email}', 'first_name': '${userObj.firstName}', 'last_name': '${userObj.lastName}'});

    if (response.statusCode == 204) {
      return response.statusCode.toString();
    } else {
      throw Exception('Failed to update user info');
    }
  } finally {
    client.close();
  }
}

Future<int> createUserBankAccount(User userObj) async {
  var client = http.Client();
  try {
    var response = await client.post(Uri.https(env["URL_PROD"].toString(), "/users/${userObj.email}/banks"),
        headers: {HttpHeaders.authorizationHeader: "Bearer ${userObj.token}"});
    if (response.statusCode == 201) {
      Map res = json.decode(response.body);

      return res['id'];
    } else {
      throw Exception('Failed to create bank account');
    }
  } finally {
    client.close();
  }
}

Future<BankAccount> getUserBankAccount(User userObj) async {
  var client = http.Client();
  try {
    var response = await client.get(Uri.https(env["URL_PROD"].toString(), "/users/${userObj.email}/banks"),
        headers: {HttpHeaders.authorizationHeader: "Bearer ${userObj.token}"});
    if (response.statusCode == 200) {
      BankAccount userAccount = BankAccount.fromJson(jsonDecode(response.body));
      return userAccount;
    } else {
      throw Exception('Failed to create bank account');
    }
  } finally {
    client.close();
  }
}

Future<int> getUserAccountBalance(User userObj) async {
  var client = http.Client();

  try {
    var response = await client.get(
        Uri.https(env["URL_PROD"].toString(), "/users/${userObj.email}/banks/${userObj.userAccount}"),
        headers: {HttpHeaders.authorizationHeader: "Bearer ${userObj.token}"});

    if (response.statusCode == 200) {
      Map res = json.decode(response.body);
      return res['balance'];
    } else {
      throw Exception('Can not retrieve account');
    }
  } finally {
    client.close();
  }
}

Digest hashPassword(String password) {
  var bytes = utf8.encode(password); // data being hashed
  var digest = sha256.convert(bytes);
  return digest;
}
