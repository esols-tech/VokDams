import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:vokdams/core/values/constants.dart';
import 'package:vokdams/data/models/project_model.dart';

class ProjectProvider {
  // * constructor
  ProjectProvider() : _dio = Dio();

  // * dio
  late Response _response;
  late final Dio _dio;

  // * rest api
  final _projectsPath = "/projects";

  getProjects() async {
    _response = await _dio.get(baseUrl + _projectsPath);

    log("get project data");
    log(_response.data.toString());

    if (_response.data["status"] && _response.data["code"] == 200) {
      return ProjectModel.fromJson(_response.data);
    } else {
      return _response.data["msg"];
    }
  }
}
