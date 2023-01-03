// To parse this JSON data, do
//
//     final listFactoryModel = listFactoryModelFromJson(jsonString);

import 'dart:convert';

List<ListFactoryModel> listFactoryModelFromJson(String str) =>
    List<ListFactoryModel>.from(
        json.decode(str).map((x) => ListFactoryModel.fromJson(x)));

String listFactoryModelToJson(List<ListFactoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListFactoryModel {
  ListFactoryModel({
    required this.idNm,
    required this.tenNm,
  });

  int idNm;
  String tenNm;

  factory ListFactoryModel.fromJson(Map<String, dynamic> json) =>
      ListFactoryModel(
        idNm: json["ID_NM"],
        tenNm: json["TEN_NM"],
      );

  Map<String, dynamic> toJson() => {
        "ID_NM": idNm,
        "TEN_NM": tenNm,
      };
}
