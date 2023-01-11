import 'package:vokdams/import_packages.dart';

class ProjectTypeModel {
  late bool status;
  late int code;
  late List<ProjectTypeData> data;
  late String message;

  ProjectTypeModel({
    this.status = false,
    this.code = -1,
    this.data = const [],
    this.message = "",
  });

  factory ProjectTypeModel.fromJson(Map<String, dynamic> json) {
    return ProjectTypeModel(
      status: json["status"],
      code: json["code"],
      data: List.from(json["data"].map((x) => ProjectTypeData.fromJson(x))),
      message: json["msg"],
    );
  }
}

class ProjectTypeData {
  late int id;
  late String name;

  ProjectTypeData({
    this.id = -1,
    this.name = "",
  });

  ProjectTypeData copy({
    int? id,
    String? name,
  }) {
    return ProjectTypeData(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  factory ProjectTypeData.fromJson(Map<String, dynamic> json) {
    return ProjectTypeData(
      id: json["id"],
      name: json["name"],
    );
  }

  Map<String, Object?> toJson() => {
        ProjectTypeFields.id: id,
        ProjectTypeFields.name: name,
      };
}
