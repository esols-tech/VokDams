import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:vokdams/core/values/constants.dart';
import 'package:vokdams/data/models/client_model.dart';

class ClientProvider {
  // * constructor
  ClientProvider._privateConstructor() : _dio = Dio();

  static final ClientProvider _instance = ClientProvider._privateConstructor();

  factory ClientProvider() {
    return _instance;
  }

  // * dio
  late Response _response;
  late final Dio _dio;

  // * rest api
  // 127.0.0.1
  // 169.254.169.180
  
  final _clientsPath = "/clients";

  Future<dynamic> getClients() async {
    _response = await _dio.get(baseUrl + _clientsPath);

    log("get clients data");
    log(_response.data.toString());

    if (_response.data["status"] && _response.data["code"] == 200) {
      return ClientModel.fromJson(_response.data);
    } else {
      return _response.data["msg"];
    }
  }
}
