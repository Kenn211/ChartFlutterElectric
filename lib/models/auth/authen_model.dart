// To parse this JSON data, do
//
//     final authenModel = authenModelFromJson(jsonString);

import 'dart:convert';

AuthenModel? authenModelFromJson(String str) =>
    AuthenModel.fromJson(json.decode(str));

String authenModelToJson(AuthenModel? data) => json.encode(data!.toJson());

class AuthenModel {
  AuthenModel({
    this.data,
  });

  Data? data;

  factory AuthenModel.fromJson(Map<String, dynamic> json) => AuthenModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.userName,
    this.updatedAt,
    this.token,
    this.password,
    this.chainId,
  });

  String? userName;
  DateTime? updatedAt;
  String? token;
  String? password;
  int? chainId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userName: json["userName"],
        updatedAt: DateTime.parse(json["updated_at"]),
        token: json["token"],
        password: json["password"],
        chainId: json["chain_id"],
      );

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "updated_at": updatedAt?.toIso8601String(),
        "token": token,
        "password": password,
        "chain_id": chainId,
      };
}
