import 'package:app/models/bankAccount.dart';

class User {
  int id;
  String email;
  String token;
  String firstName;
  String lastName;
  late int userAccount;

  User(
      {required this.id,
      required this.email,
      required this.token,
      required this.firstName,
      required this.lastName,
      int? userAccount});

  void updateToken(String inputToken) {
    token = inputToken;
  }

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        firstName = json['first_name'],
        lastName = json['last_name'],
        email = json['email'],
        token = json['token_name'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
      };
}

class Token {
  final String token;
  Token({required this.token});

  Token.fromJson(Map<String, dynamic> json) : token = json['token'];
}
