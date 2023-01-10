// To parse this JSON data, do
//
//     final revenueModel = revenueModelFromJson(jsonString);

import 'dart:convert';

RevenueModel? revenueModelFromJson(String str) =>
    RevenueModel.fromJson(json.decode(str));

String revenueModelToJson(RevenueModel? data) => json.encode(data!.toJson());

class RevenueModel {
  RevenueModel({
    this.rcan,
    this.rsmp,
    this.rbp,
    this.rcon,
    this.rdu,
    this.rdt,
    this.unitid,
    this.ngay,
    this.thanhToanDienNangThiTruong,
    this.thanhToanTinhTheoGiaDienNangThiTruong,
    this.thanhToanTinhTheoGiaChao,
    this.thanhToanChoPhanSanLuongPhatTangThem,
    this.thanhToanSanLuongSaiKhac,
    this.thanhToanCongSuatThitruong,
    this.thanhToanDichVuDuPhong,
    this.thanhToanKhac,
    this.tong,
  });

  List<Rbp?>? rcan;
  List<Rbp?>? rsmp;
  List<Rbp?>? rbp;
  List<Rbp?>? rcon;
  List<Rbp?>? rdu;
  List<Rbp?>? rdt;
  int? unitid;
  DateTime? ngay;
  String? thanhToanDienNangThiTruong;
  String? thanhToanTinhTheoGiaDienNangThiTruong;
  String? thanhToanTinhTheoGiaChao;
  String? thanhToanChoPhanSanLuongPhatTangThem;
  String? thanhToanSanLuongSaiKhac;
  String? thanhToanCongSuatThitruong;
  String? thanhToanDichVuDuPhong;
  String? thanhToanKhac;
  String? tong;

  factory RevenueModel.fromJson(Map<String, dynamic> json) => RevenueModel(
        rcan: json["Rcan"] == null
            ? []
            : List<Rbp?>.from(json["Rcan"]!.map((x) => Rbp.fromJson(x))),
        rsmp: json["Rsmp"] == null
            ? []
            : List<Rbp?>.from(json["Rsmp"]!.map((x) => Rbp.fromJson(x))),
        rbp: json["Rbp"] == null
            ? []
            : List<Rbp?>.from(json["Rbp"]!.map((x) => Rbp.fromJson(x))),
        rcon: json["Rcon"] == null
            ? []
            : List<Rbp?>.from(json["Rcon"]!.map((x) => Rbp.fromJson(x))),
        rdu: json["Rdu"] == null
            ? []
            : List<Rbp?>.from(json["Rdu"]!.map((x) => Rbp.fromJson(x))),
        rdt: json["Rdt"] == null
            ? []
            : List<Rbp?>.from(json["Rdt"]!.map((x) => Rbp.fromJson(x))),
        unitid: json["UNITID"],
        ngay: DateTime.parse(json["NGAY"]),
        thanhToanDienNangThiTruong: json["ThanhToanDienNangThiTruong"] == null
            ? ''
            : json["ThanhToanDienNangThiTruong"].toString(),
        thanhToanTinhTheoGiaDienNangThiTruong:
            json["ThanhToanTinhTheoGiaDienNangThiTruong"] == null
                ? ''
                : json["ThanhToanTinhTheoGiaDienNangThiTruong"].toString(),
        thanhToanTinhTheoGiaChao: json["ThanhToanTinhTheoGiaChao"] == null
            ? ''
            : json["ThanhToanTinhTheoGiaChao"].toString(),
        thanhToanChoPhanSanLuongPhatTangThem:
            json["ThanhToanChoPhanSanLuongPhatTangThem"] == null
                ? ''
                : json["ThanhToanChoPhanSanLuongPhatTangThem"].toString(),
        thanhToanSanLuongSaiKhac: json["ThanhToanSanLuongSaiKhac"] == null
            ? ''
            : json["ThanhToanSanLuongSaiKhac"].toString(),
        thanhToanCongSuatThitruong: json["ThanhToanCongSuatThitruong"] == null
            ? ''
            : json["ThanhToanCongSuatThitruong"].toString(),
        thanhToanDichVuDuPhong: json["ThanhToanDichVuDuPhong"] == null
            ? ''
            : json["ThanhToanDichVuDuPhong"].toString(),
        thanhToanKhac: json["ThanhToanKhac"] == null
            ? ''
            : json["ThanhToanKhac"].toString(),
        tong: json["Tong"] == null ? '' : json["Tong"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "Rcan": rcan == null
            ? []
            : List<dynamic>.from(rcan!.map((x) => x!.toJson())),
        "Rsmp": rsmp == null
            ? []
            : List<dynamic>.from(rsmp!.map((x) => x!.toJson())),
        "Rbp":
            rbp == null ? [] : List<dynamic>.from(rbp!.map((x) => x!.toJson())),
        "Rcon": rcon == null
            ? []
            : List<dynamic>.from(rcon!.map((x) => x!.toJson())),
        "Rdu":
            rdu == null ? [] : List<dynamic>.from(rdu!.map((x) => x!.toJson())),
        "Rdt":
            rdt == null ? [] : List<dynamic>.from(rdt!.map((x) => x!.toJson())),
        "UNITID": unitid,
        "NGAY": ngay?.toIso8601String(),
        "ThanhToanDienNangThiTruong": thanhToanDienNangThiTruong,
        "ThanhToanTinhTheoGiaDienNangThiTruong":
            thanhToanTinhTheoGiaDienNangThiTruong,
        "ThanhToanTinhTheoGiaChao": thanhToanTinhTheoGiaChao,
        "ThanhToanChoPhanSanLuongPhatTangThem":
            thanhToanChoPhanSanLuongPhatTangThem,
        "ThanhToanSanLuongSaiKhac": thanhToanSanLuongSaiKhac,
        "ThanhToanCongSuatThitruong": thanhToanCongSuatThitruong,
        "ThanhToanDichVuDuPhong": thanhToanDichVuDuPhong,
        "ThanhToanKhac": thanhToanKhac,
        "Tong": tong,
      };
}

class Rbp {
  Rbp({
    this.chuKy,
    this.giaTri,
  });

  int? chuKy;
  double? giaTri;

  factory Rbp.fromJson(Map<String, dynamic> json) => Rbp(
        chuKy: json["CHU_KY"],
        giaTri: json["GIA_TRI"] == null ? 0.0 : json["GIA_TRI"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "CHU_KY": chuKy,
        "GIA_TRI": giaTri,
      };
}
