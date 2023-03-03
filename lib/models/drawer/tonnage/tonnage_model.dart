// To parse this JSON data, do
//
//     final TonnageModel = TonnageModelFromJson(jsonString);

import 'dart:convert';

List<TonnageModel> tonnageModelFromJson(List<dynamic> list) =>
    List<TonnageModel>.from(list.map((x) => TonnageModel.fromJson(x)));

String tonnageModelToJson(List<TonnageModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TonnageModel {
  TonnageModel({
    required this.idNode,
    required this.ngay,
    required this.chuky,
    required this.giatri,
  });

  int idNode;
  DateTime ngay;
  int chuky;
  double giatri;

  factory TonnageModel.fromJson(Map<String, dynamic> json) => TonnageModel(
        idNode: json["ID_NODE"],
        ngay: DateTime.parse(json["NGAY"]),
        chuky: json["CHUKY"],
        giatri: json["GIATRI"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "ID_NODE": idNode,
        "NGAY": ngay.toIso8601String(),
        "CHUKY": chuky,
        "GIATRI": giatri,
      };
}
