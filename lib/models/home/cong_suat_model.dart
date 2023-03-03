List<DataCongSuat> dataCongSuatFromJson(List<dynamic> list) =>
    List<DataCongSuat>.from(list.map((x) => DataCongSuat.fromJson(x)));

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
