import 'package:crypto/crypto.dart';

class User {
  int id;
  String email;
  String token;
  String firstName;
  String lastName;

  User({required this.id, required this.email, required this.token, required this.firstName, required this.lastName});
}
