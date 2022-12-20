// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'output_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OutputModel _$OutputModelFromJson(Map<String, dynamic> json) => OutputModel(
      results: (json['results'] as List<dynamic>)
          .map((e) => PriceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OutputModelToJson(OutputModel instance) =>
    <String, dynamic>{
      'results': instance.results,
    };

PriceModel _$PriceModelFromJson(Map<String, dynamic> json) => PriceModel(
      ID_NODE: json['ID_NODE'] as int?,
      CHUKY: json['CHUKY'] as int?,
      NGAY: json['NGAY'] as String?,
      GIATRI: (json['GIATRI'] as num?)?.toDouble(),
      TO_MAY: json['TO_MAY'] as String?,
    );

Map<String, dynamic> _$PriceModelToJson(PriceModel instance) =>
    <String, dynamic>{
      'ID_NODE': instance.ID_NODE,
      'CHUKY': instance.CHUKY,
      'NGAY': instance.NGAY,
      'GIATRI': instance.GIATRI,
      'TO_MAY': instance.TO_MAY,
    };
