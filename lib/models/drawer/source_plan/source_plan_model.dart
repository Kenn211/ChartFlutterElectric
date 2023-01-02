// To parse this JSON data, do
//
//     final sourcePlanModel = sourcePlanModelFromJson(jsonString);

import 'dart:convert';

List<SourcePlanModel> sourcePlanModelFromJson(String str) =>
    List<SourcePlanModel>.from(
        json.decode(str).map((x) => SourcePlanModel.fromJson(x)));

String sourcePlanModelToJson(List<SourcePlanModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SourcePlanModel {
  SourcePlanModel({
    required this.idNm,
    required this.tenNm,
    required this.idTm,
    required this.tenTm,
    required this.ngay,
    required this.chuky,
    required this.giatri,
  });

  int idNm;
  String tenNm;
  int idTm;
  String tenTm;
  DateTime ngay;
  int chuky;
  double giatri;

  factory SourcePlanModel.fromJson(Map<String, dynamic> json) =>
      SourcePlanModel(
        idNm: json["ID_NM"],
        tenNm: json["TEN_NM"],
        idTm: json["ID_TM"],
        tenTm: json["TEN_TM"],
        ngay: DateTime.parse(json["NGAY"]),
        chuky: json["CHUKY"],
        giatri: json["GIATRI"],
      );

  Map<String, dynamic> toJson() => {
        "ID_NM": idNm,
        "TEN_NM": tenNm,
        "ID_TM": idTm,
        "TEN_TM": tenTm,
        "NGAY": ngay.toIso8601String(),
        "CHUKY": chuky,
        "GIATRI": giatri,
      };
}
