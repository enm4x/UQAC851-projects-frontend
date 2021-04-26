
class User {
  int? id;
  String email;
  String token;
  String? firstName;
  String? lastName;
  int? userAccount;

  User({this.id, required this.email, required this.token, this.firstName, this.lastName, this.userAccount});

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

  @override
  String toString() {
    return " User email --------: $email \n User id -----------: $id \n User bank account -: $userAccount";
  }
}

class Token {
  final String token;
  Token({required this.token});

  Token.fromJson(Map<String, dynamic> json) : token = json['token'];
}
