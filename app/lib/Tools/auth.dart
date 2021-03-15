import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<String> userConnection(String userCredentials, String userPassword) async {
  var client = http.Client();
  try {
    var response = await client.post(Uri.http("5.196.89.32:8888", "/auth/login"),
        body: {'email': '$userCredentials', 'password': '$userPassword'});

    if (response.statusCode == 200) {
      Map res = jsonDecode(response.body);
      // print(res['token']);
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
  try {
    var response = await client.post(Uri.http("5.196.89.32:8888", "/auth/register"),
        body: {'email': '$userCredentials', 'password': '$userPassword'});
    if (response.statusCode == 201) {
      return response.statusCode.toString();
    } else {
      throw Exception('Failed to register');
    }
  } finally {
    client.close();
  }
}

Future<String> getUserInfo(String userCredentials, String userPassword) async {
  var client = http.Client();
  try {
    var response = await client.post(Uri.http("5.196.89.32:8888", "/auth/register"),
        body: {'email': '$userCredentials', 'password': '$userPassword'});
    if (response.statusCode == 201) {
      return response.statusCode.toString();
    } else {
      throw Exception('Failed to register');
    }
  } finally {
    client.close();
  }
}

void main() async {
  var res = await userConnection("b@a.fr", "rand0m");
  print(res);

  // var x = await userRegistration("aurevoir@groupe.com", "123456");
  // print(x);
}
