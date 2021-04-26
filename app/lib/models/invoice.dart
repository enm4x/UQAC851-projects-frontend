class Invoice {
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

Invoice(
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
    });
   
  void updateAcquitted(){
    acquitted = true;
  }

  Invoice.fromJson(Map<String, dynamic> json)
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
        dueDate = json['due_date'];

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
        };
}

class InvoiceToSend{
  int amount;
  String to;
  String dueDate;

  InvoiceToSend({
    required this.amount,
    required this.to,
    required this.dueDate,
  });

  Map<String, dynamic> toJson()=> {
    'to' : to,
    'amount' : amount,
    'due_date' : dueDate,
  };

}