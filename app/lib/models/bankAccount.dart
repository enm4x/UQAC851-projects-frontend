class BankAccount {
  String createdAt;
  String updatedAt;
  int id;
  int balance;
  int userId;

  BankAccount({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.balance,
    required this.userId,
  });

  BankAccount.fromJson(Map<String, dynamic> json)
      : createdAt = json['created_at'],
        updatedAt = json['updated_at'],
        id = json['id'],
        balance = json['balance'],
        userId = json['user_id'];

  Map<String, dynamic> toJson() => {
        'created_at': createdAt,
        'updated_at': updatedAt,
        'id': id,
        'balance': balance,
        'user_id': userId
      };
}
