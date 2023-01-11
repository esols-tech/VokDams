import 'package:vokdams/import_packages.dart';

class IndustryModel {
  late bool status;
  late int code;
  late List<IndustryData> data;
  late String message;

  IndustryModel({
    this.status = false,
    this.code = -1,
    this.data = const [],
    this.message = "",
  });

  factory IndustryModel.fromJson(Map<String, dynamic> json) {
    return IndustryModel(
      status: json["status"],
      code: json["code"],
      data: List.from(json["data"].map((x) => IndustryData.fromJson(x))),
      message: json["msg"],
    );
  }
}

class IndustryData {
  late int id;
  late String name;

  IndustryData({
    this.id = -1,
    this.name = "",
  });

  IndustryData copy({
    int? id,
    String? name,
  }) {
    return IndustryData(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  factory IndustryData.fromJson(Map<String, dynamic> json) {
    return IndustryData(
      id: json["id"],
      name: json["name"],
    );
  }

  Map<String, Object?> toJson() => {
        IndustryFields.id: id,
        IndustryFields.name: name,
      };
}
