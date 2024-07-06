// To parse this JSON data, do
//
//     final user = userListFromJson(jsonString);
import 'dart:convert';

List<UserList> userFromJson(String str) => List<UserList>.from(json.decode(str).map((x) => UserList.fromJson(x)));

String userListToJson(List<UserList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserList {
  String userId;
  String name;
  int age;
  String sexTy;
  String note;

  UserList({
    required this.userId,
    required this.name,
    required this.age,
    required this.sexTy,
    required this.note,
  });

  factory UserList.fromJson(Map<String, dynamic> json) => UserList(
    userId: json["user_id"],
    name: json["name"],
    age: json["age"],
    sexTy: json["sex_ty"],
    note: json["note"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "name": name,
    "age": age,
    "sex_ty": sexTy,
    "note": note,
  };
}
