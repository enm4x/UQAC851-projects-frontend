import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';

import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart';
import 'dart:async';

import 'package:app/models/user.dart';
import 'package:app/Tools/auth.dart';

Future<String> userConnectionTest(
    String userCredentials, String userPassword, MockClient client) async {
  final Digest pwdHash = hashPassword(userPassword);
  try {
    var response = await client
        .post(Uri.https('domain.name:1234', "/auth/login"), body: {
      'email': '$userCredentials',
      'password': '${pwdHash.toString()}'
    });
    if (response.statusCode == 200) {
      var tok = Token.fromJson(jsonDecode(response.body));

      return tok.token;
    } else {
      throw Exception('Failed to log-in');
    }
  } finally {
    client.close();
  }
}

Future<String> userRegistrationTest(
    String userCredentials, String userPassword, MockClient client) async {
  final Digest pwdHash = hashPassword(userPassword);

  try {
    var response = await client
        .post(Uri.https('domain.name:1234', "/auth/register"), body: {
      'email': '$userCredentials',
      'password': '${pwdHash.toString()}'
    });
    if (response.statusCode == 201) {
      return response.body;
    } else {
      throw Exception('Failed to register');
    }
  } finally {
    client.close();
  }
}

void main() async {
  group(
      "Scope: API | Fonction: userLogin | Test => ",
      () => {
            test("Succes - 200", () async {
              var fakeHttpClient = MockClient((request) async {
                final mapJson = {'token': "i.am.a.token"};
                return Response(json.encode(mapJson), 200);
              });
              // print("########: premier log");
              var res = await userConnectionTest(
                  "example@email.com", "12345", fakeHttpClient);
              expect(res, "i.am.a.token");
            }),
            test("Failing - 500", () async {
              var fakeHttpClient = MockClient((request) async {
                return Response('internal server error', 500);
              });
              try {
                await userConnectionTest(
                    "example@email.com", "12345", fakeHttpClient);
                fail("exception not thrown");
              } catch (e) {
                // print("########: deuxieme log");

                expect(e, isInstanceOf<Exception>());
              }
            })
          });
  group(
      "Scope: API | Fonction: userCreation | Test => ",
      () => {
            test("Success - 201", () async {
              var fakeHttpClient = MockClient((request) async {
                final mapJson = {'id': 1};
                return Response(json.encode(mapJson), 201);
              });

              var response = await userRegistrationTest(
                  "example@email.com", "12345", fakeHttpClient);
              var id = jsonDecode(response);
              expect(id["id"], 1);
            }),
            test("Failure - 500", () async {
              var fakeHttpClient = MockClient((request) async {
                return Response('internal server error', 500);
              });

              try {
                await userRegistrationTest(
                    "example@email.com", "12345", fakeHttpClient);
                fail("exception not thrown");
              } catch (e) {
                // print("########: deuxieme log");

                expect(e, isInstanceOf<Exception>());
              }
            })
          });
}
