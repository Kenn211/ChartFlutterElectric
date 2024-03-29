// To parse this JSON data, do
//
//     final priceModel = priceModelFromJson(jsonString);

import 'dart:convert';

List<PriceModel> priceModelFromJson(List<dynamic> list) =>
    // ignore: unnecessary_lambdas
    List<PriceModel>.from(list.map((x) => PriceModel.fromJson(x)));

String priceModelToJson(List<PriceModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PriceModel {
  PriceModel(
      {required this.idNode,
      required this.ngay,
      required this.chuky,
      required this.giatri,
      required this.toMay});

  factory PriceModel.fromJson(Map<String, dynamic> json) => PriceModel(
      idNode: json['ID_NODE'],
      ngay: DateTime.parse(json['NGAY']),
      chuky: json['CHUKY'],
      giatri: json['GIATRI'].toDouble(),
      toMay: json['TO_MAY']);

  Map<String, dynamic> toJson() => {
        'ID_NODE': idNode,
        'NGAY': ngay.toIso8601String(),
        'CHUKY': chuky,
        'GIATRI': giatri,
        'TO_MAY': toMay
      };

  int idNode;
  DateTime ngay;
  int chuky;
  double giatri;
  String toMay;
}
