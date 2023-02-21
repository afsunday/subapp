import 'dart:convert';

History historyFromJson(String str) => History.fromJson(json.decode(str));

String historyToJson(History data) => json.encode(data.toJson());

class History {
    History({
        required this.id,
        required this.userId,
        required this.itemImage,
        required this.transactionRef,
        required this.amount,
        required this.description,
        required this.entry,
        required this.status,
        required this.transactionDate,
        required this.createdAt,
        required this.updatedAt,
    });

    int id;
    String userId;
    String itemImage;
    String transactionRef;
    double amount;
    String description;
    String entry;
    String status;
    DateTime transactionDate;
    DateTime createdAt;
    DateTime updatedAt;

    factory History.fromJson(Map<String, dynamic> json) => History(
        id: json["id"],
        userId: json["user_id"],
        itemImage: json["item_image"],
        transactionRef: json["transaction_ref"],
        amount: double.parse(json["amount"]),
        description: json["description"],
        entry: json["entry"],
        status: json["status"],
        transactionDate: DateTime.parse(json["transaction_date"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "item_image": itemImage,
        "transaction_ref": transactionRef,
        "amount": amount,
        "description": description,
        "entry": entry,
        "status": status,
        "transaction_date": transactionDate.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
