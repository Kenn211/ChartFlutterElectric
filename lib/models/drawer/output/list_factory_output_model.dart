// To parse this JSON data, do
//
//     final listFactoryOutputModel = listFactoryOutputModelFromJson(jsonString);

import 'dart:convert';

List<ListFactoryOutputModel> listFactoryOutputModelFromJson(
        List<dynamic> list) =>
    List<ListFactoryOutputModel>.from(
        list.map((x) => ListFactoryOutputModel.fromJson(x)));

String listFactoryOutputModelToJson(List<ListFactoryOutputModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListFactoryOutputModel {
  ListFactoryOutputModel({
    required this.unitid,
    required this.unitName,
  });
  factory ListFactoryOutputModel.fromJson(Map<String, dynamic> json) =>
      ListFactoryOutputModel(
        unitid: json['UNITID'],
        unitName: json['UNIT_NAME'],
      );

  Map<String, dynamic> toJson() => {
        'UNITID': unitid,
        'UNIT_NAME': unitName,
      };
  int unitid;
  String unitName;
}
