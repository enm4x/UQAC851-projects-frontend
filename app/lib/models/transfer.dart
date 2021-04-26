class Transfer {
  String createdAt;
  String updatedAt;
  int id;
  int amount;
  String from;
  String to;
  int senderId;
  int receiverId;

  bool transfer;
  bool instant;
  bool scheduled;
  String date;
  String question;
  String answer;
  bool verified;
  int verificationTry;

//  "created_at": "2021-04-24T23:17:02.864Z",
//         "updated_at": "2021-04-24T23:19:22.779Z",
//         "id": 1,
//         "amount": 10,
//         "from": "user1prixbanque@gmail.com",
//         "to": "user2prixbanque@gmail.com",
//         "sender_id": 1,
//         "receiver_id": 2,
//         "transfer": true,
//         "instant": true,
//         "scheduled": false,
//         "date": "2021-04-22T00:00:00Z",
//         "question": "To be or not ?",
//         "answer": "1234",
//         "verified": false,
//         "try": 3
//
  Transfer(
      {required this.createdAt,
      required this.updatedAt,
      required this.id,
      required this.from,
      required this.to,
      required this.amount,
      required this.senderId,
      required this.receiverId,
      required this.transfer,
      required this.instant,
      required this.scheduled,
      required this.date,
      required this.question,
      required this.answer,
      required this.verified,
      required this.verificationTry});

  Transfer.fromJson(Map<String, dynamic> json)
      : createdAt = json['created_at'],
        updatedAt = json['updated_at'],
        id = json['id'],
        from = json['from'],
        to = json['to'],
        amount = json["amount"],
        senderId = json["sender_id"],
        receiverId = json["receiver_id"],
        transfer = json["transfer"],
        instant = json["instant"],
        scheduled = json["scheduled"],
        date = json["date"],
        question = json["question"],
        answer = json["answer"],
        verified = json['verified'],
        verificationTry = json['try'];

  Map<String, dynamic> toJson() => {
        'created_at': createdAt,
        'updated_at': updatedAt,
        'id': id,
        'amount': amount,
        'sender_id': senderId,
        'receiver_id': receiverId,
        'transfer': transfer,
        'instant': instant,
        'scheduled': scheduled,
        'date': date,
        'question': question,
        'answer': answer
      };

  @override
  String toString() {
    return " Transfer id ------------- : $id \n Transfer sender : --------: $senderId \n Transfer receiver ------- : $receiverId \n Transfer amount --------- : $amount \n Transfer is instant ----- : $instant \n Transfer is scheduled --- : $scheduled";
  }
}

class TransferToSend {
  int amount;
  String to;
  bool instant;
  bool scheduled;
  String date;
  String question;
  String answer;

  TransferToSend({
    required this.to,
    required this.amount,
    required this.instant,
    required this.scheduled,
    required this.date,
    required this.question,
    required this.answer,
  });

  Map<String, dynamic> toJson() => {
        'to': to,
        'amount': amount,
        'instant': instant,
        'scheduled': scheduled,
        'date': date,
        'question': question,
        'answer': answer
      };

  @override
  String toString() {
    return " Transfer to ------------- : $to \n Transfer amount --------- : $amount \n Transfer is instant ----- : $instant \n Transfer is scheduled --- : $scheduled \n Transfer date ----------- : $date   \n Transfer question : ------: $question \n Transfer answer : --------: $answer";
  }
}
