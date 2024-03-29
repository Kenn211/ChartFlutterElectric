// To parse this JSON data, do
//
//     final dataLakeModel = dataLakeModelFromJson(jsonString);

import 'dart:convert';

// ignore: avoid_annotating_with_dynamic
DataLakeModel dataLakeModelFromJson(dynamic str) => DataLakeModel.fromJson(str);

String dataLakeModelToJson(DataLakeModel data) => json.encode(data.toJson());

class DataLakeModel {
  DataLakeModel({
    required this.mucnuocGioihantren,
    required this.mucnuocGioihanduoi,
    required this.mucnuocKehoachnam,
    required this.mucnuocNamhientai,
    required this.mucnuocNamquakhu,
    required this.mucnuocDangbinhthuong,
    required this.mucnuocChet,
    required this.idHo,
    required this.ngay,
  });

  factory DataLakeModel.fromJson(Map<String, dynamic> json) => DataLakeModel(
        mucnuocGioihantren: List<Mucnuoc>.from(
            json['MUCNUOC_GIOIHANTREN'].map(Mucnuoc.fromJson)),
        mucnuocGioihanduoi: List<Mucnuoc>.from(
            json['MUCNUOC_GIOIHANDUOI'].map(Mucnuoc.fromJson)),
        mucnuocKehoachnam: List<Mucnuoc>.from(
            json['MUCNUOC_KEHOACHNAM'].map(Mucnuoc.fromJson)),
        mucnuocNamhientai: List<Mucnuoc>.from(
            json['MUCNUOC_NAMHIENTAI'].map(Mucnuoc.fromJson)),
        mucnuocNamquakhu:
            List<Mucnuoc>.from(json['MUCNUOC_NAMQUAKHU'].map(Mucnuoc.fromJson)),
        mucnuocDangbinhthuong: List<Mucnuoc>.from(
            json['MUCNUOC_DANGBINHTHUONG'].map(Mucnuoc.fromJson)),
        mucnuocChet:
            List<Mucnuoc>.from(json['MUCNUOC_CHET'].map(Mucnuoc.fromJson)),
        idHo: json['ID_HO'],
        ngay: DateTime.parse(json['NGAY']),
      );

  List<Mucnuoc> mucnuocGioihantren;
  List<Mucnuoc> mucnuocGioihanduoi;
  List<Mucnuoc> mucnuocKehoachnam;
  List<Mucnuoc> mucnuocNamhientai;
  List<Mucnuoc> mucnuocNamquakhu;
  List<Mucnuoc> mucnuocDangbinhthuong;
  List<Mucnuoc> mucnuocChet;
  int idHo;
  DateTime ngay;

  Map<String, dynamic> toJson() => {
        'MUCNUOC_GIOIHANTREN':
            List<dynamic>.from(mucnuocGioihantren.map((x) => x.toJson())),
        'MUCNUOC_GIOIHANDUOI':
            List<dynamic>.from(mucnuocGioihanduoi.map((x) => x.toJson())),
        'MUCNUOC_KEHOACHNAM':
            List<dynamic>.from(mucnuocKehoachnam.map((x) => x.toJson())),
        'MUCNUOC_NAMHIENTAI':
            List<dynamic>.from(mucnuocNamhientai.map((x) => x.toJson())),
        'MUCNUOC_NAMQUAKHU':
            List<dynamic>.from(mucnuocNamquakhu.map((x) => x.toJson())),
        'MUCNUOC_DANGBINHTHUONG':
            List<dynamic>.from(mucnuocDangbinhthuong.map((x) => x.toJson())),
        'MUCNUOC_CHET': List<dynamic>.from(mucnuocChet.map((x) => x.toJson())),
        'ID_HO': idHo,
        'NGAY': ngay.toIso8601String(),
      };
}

class Mucnuoc {
  Mucnuoc({
    required this.waterDay,
    required this.value,
  });

  factory Mucnuoc.fromJson(Map<String, dynamic> json) => Mucnuoc(
        waterDay: json['WATER_DAY'],
        value: json['VALUE'] == null ? 0 : json['VALUE'].toDouble(),
      );

  String waterDay;
  double value;

  Map<String, dynamic> toJson() => {
        'WATER_DAY': waterDay,
        'VALUE': value,
      };
}
