import 'dart:convert';

List<DataCongSuat> dataCongSuatFromJson(String str) => List<DataCongSuat>.from(
    json.decode(str).map((x) => DataCongSuat.fromJson(x)));

String dataCongSuatToJson(List<DataCongSuat> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DataCongSuat {
  DataCongSuat({
    required this.idtb,
    required this.tentb,
    required this.congsuat,
  });

  String idtb;
  String tentb;
  double congsuat;

  factory DataCongSuat.fromJson(Map<String, dynamic> json) => DataCongSuat(
        idtb: json["IDTB"],
        tentb: json["TENTB"],
        congsuat: json["CONGSUAT"],
      );

  Map<String, dynamic> toJson() => {
        "IDTB": idtb,
        "TENTB": tentb,
        "CONGSUAT": congsuat,
      };
}
