import 'dart:convert';

PeerData peerDataFromJson(String str) => PeerData.fromJson(json.decode(str));

String peerDataToJson(PeerData data) => json.encode(data.toJson());

class PeerData {
    PeerData({
        required this.currentPage,
        required this.data,
        required this.firstPageUrl,
        required this.from,
        required this.nextPageUrl,
        required this.path,
        required this.perPage,
        this.prevPageUrl,
        required this.to,
    });

    int currentPage;
    List<Peer> data;
    String firstPageUrl;
    int from;
    String nextPageUrl;
    String path;
    int perPage;
    dynamic prevPageUrl;
    int to;

    factory PeerData.fromJson(Map<String, dynamic> json) => PeerData(
        currentPage: json["current_page"],
        data: List<Peer>.from(json["data"].map((x) => Peer.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
    };
}

class Peer {
    Peer({
        required this.id,
        required this.userId,
        required this.avatar,
        required this.firstName,
        required this.lastName,
        required this.phoneNumber,
        required this.createdAt,
        required this.updatedAt,
    });

    int id;
    String userId;
    String avatar;
    String firstName;
    String lastName;
    String phoneNumber;
    DateTime createdAt;
    DateTime updatedAt;

    factory Peer.fromJson(Map<String, dynamic> json) => Peer(
        id: json["id"],
        userId: json["user_id"],
        avatar: json["avatar"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phoneNumber: json["phone_number"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "avatar": avatar,
        "first_name": firstName,
        "last_name": lastName,
        "phone_number": phoneNumber,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
