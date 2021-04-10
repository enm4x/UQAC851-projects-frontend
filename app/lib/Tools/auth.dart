import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:app/models/user.dart';
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

Future<String> userRegistration(String userCredentials, String userPassword) async {
  var client = http.Client();
  final Digest pwdHash = hashPassword(userPassword);

  try {
    var response = await client.post(Uri.https(env["URL_PROD"].toString(), "/auth/register"),
        body: {'email': '$userCredentials', 'password': '${pwdHash.toString()}'});
    if (response.statusCode == 201) {
      return response.statusCode.toString();
    } else {
      throw Exception('Failed to register');
    }
  } finally {
    client.close();
  }
}

Future<String> getUserInfo(User userObj) async {
  var client = http.Client();

  try {
    var response = await client.get(
      Uri.https(env["URL_PROD"].toString(), "/users/${userObj.email}"),
      headers: {HttpHeaders.authorizationHeader: "Bearer ${userObj.token}"},
    );

    if (response.statusCode == 200) {
      return response.body.toString();
    } else {
      throw Exception('Can not retrieve user informations');
    }
  } finally {
    client.close();
  }
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

Digest hashPassword(String password) {
  var bytes = utf8.encode(password); // data being hashed
  var digest = sha256.convert(bytes);
  return digest;
}
