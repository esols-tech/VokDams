import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:vokdams/core/values/constants.dart';
import 'package:vokdams/data/models/industry_model.dart';

class IndustryProvider {
  // * constructor
  IndustryProvider() : _dio = Dio();

  // * dio
  late Response _response;
  late final Dio _dio;

  // * rest api
  final _industriesPath = "/industries";

  Future<dynamic> getIndustries() async {
    _response = await _dio.get(baseUrl + _industriesPath);

    log("get industries data");
    log(_response.data.toString());

    if (_response.data["status"] && _response.data["code"] == 200) {
      return IndustryModel.fromJson(_response.data);
    } else {
      return _response.data["msg"];
    }
  }
}
