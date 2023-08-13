// To parse this JSON data, do
//
//     final outPutModel = outPutModelFromJson(jsonString);

import 'dart:convert';

OutPutModel outPutModelFromJson(dynamic str) => OutPutModel.fromJson(str);

String outPutModelToJson(OutPutModel data) => json.encode(data.toJson());

class OutPutModel {
  OutPutModel({
    required this.can,
    required this.smp,
    required this.gcnn,
    required this.gcln,
    required this.qcan,
    required this.qlltt,
    required this.unitid,
    required this.ngay,
  });

  factory OutPutModel.fromJson(Map<String, dynamic> json) => OutPutModel(
        can: List<Can>.from(json['CAN'].map(Can.fromJson)),
        smp: List<Can>.from(json['SMP'].map(Can.fromJson)),
        gcnn: List<Can>.from(json['GCNN'].map(Can.fromJson)),
        gcln: List<Can>.from(json['GCLN'].map(Can.fromJson)),
        qcan: List<Can>.from(json['QCAN'].map(Can.fromJson)),
        qlltt: List<Can>.from(json['QLLTT'].map(Can.fromJson)),
        unitid: json['UNITID'],
        ngay: DateTime.parse(json['NGAY']),
      );

  List<Can> can;
  List<Can> smp;
  List<Can> gcnn;
  List<Can> gcln;
  List<Can> qcan;
  List<Can> qlltt;
  int unitid;
  DateTime ngay;

  Map<String, dynamic> toJson() => {
        'CAN': List<dynamic>.from(can.map((x) => x.toJson())),
        'SMP': List<dynamic>.from(smp.map((x) => x.toJson())),
        'GCNN': List<dynamic>.from(gcnn.map((x) => x.toJson())),
        'GCLN': List<dynamic>.from(gcln.map((x) => x.toJson())),
        'QCAN': List<dynamic>.from(qcan.map((x) => x.toJson())),
        'QLLTT': List<dynamic>.from(qlltt.map((x) => x.toJson())),
        'UNITID': unitid,
        'NGAY': ngay.toIso8601String(),
      };
}

class Can {
  Can({
    required this.chuKy,
    required this.giaTri,
  });

  factory Can.fromJson(Map<String, dynamic> json) => Can(
        chuKy: json['CHU_KY'],
        giaTri: json['GIA_TRI'].toDouble(),
      );

  int chuKy;
  double giaTri;

  Map<String, dynamic> toJson() => {
        'CHU_KY': chuKy,
        'GIA_TRI': giaTri,
      };
}
