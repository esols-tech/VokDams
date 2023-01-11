import 'package:vokdams/import_packages.dart';

class ClientModel {
  late bool status;
  late int code;
  late List<ClientData> data;
  late String message;

  ClientModel({
    this.status = false,
    this.code = -1,
    this.data = const [],
    this.message = "",
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      status: json["status"],
      code: json["code"],
      data: List.from(json["data"].map((x) => ClientData.fromJson(x))),
      message: json["msg"],
    );
  }
}

class ClientData {
  late int id;
  late String name;

  ClientData({
    this.id = -1,
    this.name = "",
  });

  ClientData copy({
    int? id,
    String? name,
  }) {
    return ClientData(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  factory ClientData.fromJson(Map<String, dynamic> json) {
    return ClientData(
      id: json["id"],
      name: json["name"],
    );
  }

  Map<String, Object?> toJson() => {
        ClientFields.id: id,
        ClientFields.name: name,
      };
}
