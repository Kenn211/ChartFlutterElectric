// To parse this JSON data, do
//
//     final listLakeModel = listLakeModelFromJson(jsonString);

import 'dart:convert';

List<ListLakeModel> listLakeModelFromJson(List<dynamic> list) =>
    List<ListLakeModel>.from(list.map((x) => ListLakeModel.fromJson(x)));

String listLakeModelToJson(List<ListLakeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListLakeModel {
  ListLakeModel({
    required this.idHo,
    required this.maHo,
    required this.idNm,
    required this.maNm,
    required this.tenHo,
    required this.moTa,
    required this.stt,
    required this.enable,
  });

  int idHo;
  String maHo;
  int idNm;
  String maNm;
  String tenHo;
  String moTa;
  int stt;
  bool enable;

  factory ListLakeModel.fromJson(Map<String, dynamic> json) => ListLakeModel(
        idHo: json["ID_HO"],
        maHo: json["MA_HO"],
        idNm: json["ID_NM"],
        maNm: json["MA_NM"],
        tenHo: json["TEN_HO"],
        moTa: json["MO_TA"],
        stt: json["STT"],
        enable: json["Enable"],
      );

  Map<String, dynamic> toJson() => {
        "ID_HO": idHo,
        "MA_HO": maHo,
        "ID_NM": idNm,
        "MA_NM": maNm,
        "TEN_HO": tenHo,
        "MO_TA": moTa,
        "STT": stt,
        "Enable": enable,
      };
}
