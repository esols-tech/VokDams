import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:vokdams/core/values/constants.dart';
import 'package:vokdams/data/models/project_type_model.dart';

class ProjectTypeProvider {
  // * constructor
  ProjectTypeProvider() : _dio = Dio();

  // * dio
  late Response _response;
  late final Dio _dio;

  // * rest api
  // 127.0.0.1
  final _projectsTypesPath = "/projects_types";

  Future<dynamic> getProjectsTypes() async {
    _response = await _dio.get(baseUrl + _projectsTypesPath);

    log("get projects types data");
    log(_response.data.toString());

    if (_response.data["status"] && _response.data["code"] == 200) {
      return ProjectTypeModel.fromJson(_response.data);
    } else {
      return _response.data["msg"];
    }
  }
}
