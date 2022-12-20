// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'output_model.g.dart';

@JsonSerializable()
class OutputModel {
  final List<PriceModel> results;

  OutputModel({
    required this.results,
  });

  factory OutputModel.fromJson(Map<String, dynamic> json) =>
      _$OutputModelFromJson(json);

  Map<String, dynamic> toJson() => _$OutputModelToJson(this);
}

@JsonSerializable()
class PriceModel {
  final int? ID_NODE;
  final int? CHUKY;
  final String? NGAY;
  final double? GIATRI;
  final String? TO_MAY;

  PriceModel({
    this.ID_NODE,
    this.CHUKY,
    this.NGAY,
    this.GIATRI,
    this.TO_MAY,
  });

  factory PriceModel.fromJson(Map<String, dynamic> json) =>
      _$PriceModelFromJson(json);

  Map<String, dynamic> toJson() => _$PriceModelToJson(this);
}
