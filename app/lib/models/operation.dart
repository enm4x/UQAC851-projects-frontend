class Operation {
  String createdAt;
  String updatedAt;
  int id;
  int amount;
  String from;
  String to;
  int senderId;
  int receiverId;
  bool invoice;
  bool acquitted;
  String dueDate;
  bool transfer;
  bool instant;
  bool scheduled;
  String date;

Operation(
  {required this.createdAt,
  required this.updatedAt,
    required this.id,
    required this.amount,
    required this.from,
    required this.to,
    required this.senderId,
    required this.receiverId,
    required this.invoice,
    required this.acquitted,
    required this.dueDate,
    required this.transfer,
    required this.instant,
    required this.scheduled,
    required this.date,
    });
   
  void updateAcquitted(){
    acquitted = true;
  }

  Operation.fromJson(Map<String, dynamic> json)
        : createdAt = json['created_at'],
        updatedAt = json['updated_at'],
        id = json['id'],
        amount = json['amount'],
        from = json['from'],
        to = json['to'],
        senderId = json['sender_id'],
        receiverId = json['receiver_id'], 
        invoice = json['invoice'],
        acquitted = json['acquitted'],
        dueDate = json['due_date'],
        transfer = json['transfer'],
        instant = json['instant'],
        scheduled = json['scheduled'],
        date = json['date'];

        Map<String, dynamic> toJson() => {
          'created_at':createdAt,
          'updated_at':updatedAt,
          'id':id,
          'amount':amount,
          'from':from,
          'to':to,
          'sender_id':senderId,
          'receiver_id':receiverId,
          'invoice':invoice,
          'acquitted':acquitted,
          'due_date':dueDate,
          'transfer':transfer,
          'instant':instant,
          'scheduled':scheduled,
          'date':date,
        };
}