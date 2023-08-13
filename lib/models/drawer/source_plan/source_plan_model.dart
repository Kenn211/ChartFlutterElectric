// To parse this JSON data, do
//
//     final sourcePlanModel = sourcePlanModelFromJson(jsonString);

import 'dart:convert';

SourcePlanModel sourcePlanModelFromJson(dynamic str) =>
    SourcePlanModel.fromJson(str);

String sourcePlanModelToJson(SourcePlanModel data) =>
    json.encode(data.toJson());

class SourcePlanModel {
  SourcePlanModel({
    required this.toMay,
    required this.idNm,
    required this.tenNm,
    required this.ngay,
  });

  factory SourcePlanModel.fromJson(Map<String, dynamic> json) =>
      SourcePlanModel(
        toMay: List<ToMay>.from(json['TO_MAY'].map(ToMay.fromJson)),
        idNm: json['ID_NM'],
        tenNm: json['TEN_NM'],
        ngay: DateTime.parse(json['NGAY']),
      );

  List<ToMay> toMay;
  int idNm;
  String tenNm;
  DateTime ngay;

  Map<String, dynamic> toJson() => {
        'TO_MAY': List<dynamic>.from(toMay.map((x) => x.toJson())),
        'ID_NM': idNm,
        'TEN_NM': tenNm,
        'NGAY': ngay.toIso8601String(),
      };
}

class ToMay {
  ToMay({
    required this.chuky,
    required this.idTm,
    required this.tenTm,
  });

  factory ToMay.fromJson(Map<String, dynamic> json) => ToMay(
        chuky: List<Chuky>.from(json['CHUKY'].map((x) => Chuky.fromJson(x))),
        idTm: json['ID_TM'],
        tenTm: json['TEN_TM'],
      );

  List<Chuky> chuky;
  int idTm;
  String tenTm;

  Map<String, dynamic> toJson() => {
        'CHUKY': List<dynamic>.from(chuky.map((x) => x.toJson())),
        'ID_TM': idTm,
        'TEN_TM': tenTm,
      };
}

class Chuky {
  Chuky({
    required this.chuKyDesc,
    required this.giaTri,
  });

  factory Chuky.fromJson(Map<String, dynamic> json) => Chuky(
        chuKyDesc: json['CHU_KY'],
        giaTri: json['GIA_TRI'].toDouble(),
      );

  int chuKyDesc;
  double giaTri;

  Map<String, dynamic> toJson() => {
        'CHU_KY': chuKyDesc,
        'GIA_TRI': giaTri,
      };
}
