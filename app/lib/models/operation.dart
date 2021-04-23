class Operation {
  String createdAt;
  String updatedAt;
  String deletedAt;
  int id;
  int amount;
  int senderId;
  int receiverId;
  bool invoice;
  bool acquitted;
  String dueDate;
  bool transfer;
  bool instant;
  bool scheduled;
  String date;
  String question;
  String answer;

Operation(
  {required this.createdAt,
  required this.updatedAt,
  required this.deletedAt,
    required this.id,
    required this.amount,
    required this.senderId,
    required this.receiverId,
    required this.invoice,
    required this.acquitted,
    required this.dueDate,
    required this.transfer,
    required this.instant,
    required this.scheduled,
    required this.date,
    required this.question,
    required this.answer
    });
   
  void updateAcquitted(){
    acquitted = true;
  }

  Operation.fromJson(Map<String, dynamic> json)
        : createdAt = json['created_at'],
        updatedAt = json['updated_at'],
        deletedAt = json['deleted_at'],
        id = json['id'],
        amount = json["amount"],
        senderId = json["sender_id"],
        receiverId = json["receiver_id"], 
        invoice = json["invoice"],
        acquitted = json["acquitted"],
        dueDate = json["due_date"],
        transfer = json["transfer"],
        instant = json["instant"],
        scheduled = json["scheduled"],
        date = json["date"],
        question = json["question"],
        answer = json["answer"];

        Map<String, dynamic> toJson()=> {
          'created_at':createdAt,
          'updated_at':updatedAt,
          'deleted_at':deletedAt,
          'id':id,
          'amount':amount,
          'sender_id':senderId,
          'receiver_id':receiverId,
          'invoice':invoice,
          'acquitted':acquitted,
          'due_date':dueDate,
          'transfer':transfer,
          'instant':instant,
          'scheduled':scheduled,
          'date':date,
          'question':question,
          'answer':answer
        };

}