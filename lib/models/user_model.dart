import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    User({
        required this.id,
        required this.firstname,
        required this.lastname,
        required this.userType,
        this.accountNumber,
        this.accountName,
        this.bankName,
        required this.walletBalance,
        required this.totalContacts,
        required this.phone,
        required this.email,
        required this.avatar,
        this.emailVerifiedAt,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
    });

    int id;
    String firstname;
    String lastname;
    String userType;
    dynamic accountNumber;
    dynamic accountName;
    dynamic bankName;
    double walletBalance;
    int totalContacts;
    String phone;
    String email;
    String avatar;
    dynamic emailVerifiedAt;
    bool status;
    DateTime createdAt;
    DateTime updatedAt;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        userType: json["user_type"],
        accountNumber: json["account_number"],
        accountName: json["account_name"],
        bankName: json["bank_name"],
        walletBalance: double.parse(json["wallet_balance"]),
        totalContacts: int.parse(json["total_contacts"]),
        phone: json["phone"],
        email: json["email"],
        avatar: json["avatar"],
        emailVerifiedAt: json["email_verified_at"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "user_type": userType,
        "account_number": accountNumber,
        "account_name": accountName,
        "bank_name": bankName,
        "wallet_balance": walletBalance,
        "total_contacts": totalContacts,
        "phone": phone,
        "email": email,
        "avatar": avatar,
        "email_verified_at": emailVerifiedAt,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
