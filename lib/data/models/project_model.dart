import 'package:vokdams/import_packages.dart';

class ProjectModel {
  late bool status;
  late int code;
  late List<ProjectData> data;
  late String message;

  ProjectModel({
    this.status = false,
    this.code = -1,
    this.data = const [],
    this.message = "",
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      status: json["status"],
      code: json["code"],
      data: List.from(json["data"].map((x) => ProjectData.fromJson(x))),
      message: json["msg"],
    );
  }
}

class ProjectData {
  late int id;
  late int clientId;
  late int industryId;
  late List<dynamic> projectsTypes;
  late String title;
  late String occasion;
  late String motto;
  late String targetGroup;
  late List<dynamic> implementation;
  late String conclusion;
  late String mainImageUrl;
  late List<dynamic> optionalImagesUrls;
  late List<dynamic> optionalVideosUrls;

  ProjectData({
    this.id = -1,
    this.clientId = -1,
    this.industryId = -1,
    this.projectsTypes = const [],
    this.title = "",
    this.occasion = "",
    this.motto = "",
    this.targetGroup = "",
    this.implementation = const [],
    this.conclusion = "",
    this.mainImageUrl = "",
    this.optionalImagesUrls = const [],
    this.optionalVideosUrls = const [],
  });

  // ProjectData copy({
  //   int? id,
  //   int? clientId,
  //   int? industryId,
  //   // List<dynamic>? projectsTypes,
  //   String? title,
  //   String? occasion,
  //   String? motto,
  //   String? targetGroup,
  //   // List<dynamic>? implementation,
  //   String? conclusion,
  //   String? mainImageUrl,
  //   // List<dynamic>? optionalImagesUrls,
  //   // List<dynamic>? optionalVideosUrls,
  // }) {
  //   return ProjectData(
  //     id: id ?? this.id,
  //     clientId: clientId ?? this.clientId,
  //     industryId: industryId ?? this.industryId,
  //     // projectsTypes: projectsTypes ?? this.projectsTypes,
  //     title: title ?? this.title,
  //     occasion: occasion ?? this.occasion,
  //     motto: motto ?? this.motto,
  //     targetGroup: targetGroup ?? this.targetGroup,
  //     // implementation: implementation ?? this.implementation,
  //     conclusion: conclusion ?? this.conclusion,
  //     mainImageUrl: mainImageUrl ?? this.mainImageUrl,
  //     // optionalImagesUrls: optionalImagesUrls ?? this.optionalImagesUrls,
  //     // optionalVideosUrls: optionalVideosUrls ?? this.optionalVideosUrls,
  //   );
  // }

  factory ProjectData.fromJson(Map<String, dynamic> json) {
    return ProjectData(
      id: json["id"],
      clientId: json["client_id"],
      industryId: json["industry_id"],
      projectsTypes: json["projects_types"],
      title: json["title"],
      occasion: json["occasion"],
      motto: json["motto"],
      targetGroup: json["target_group"],
      implementation: json["implementation"],
      conclusion: json["conclusion"],
      mainImageUrl: json["main_image_url"],
      optionalImagesUrls: json["optional_images_urls"],
      optionalVideosUrls: json["optional_videos_urls"],
    );
  }

  factory ProjectData.fromJsonLocalDatabase(Map<String, dynamic> json) {
    return ProjectData(
      id: json["id"],
      clientId: json["client_id"],
      industryId: json["industry_id"],
      title: json["title"],
      occasion: json["occasion"],
      motto: json["motto"],
      targetGroup: json["target_group"],
      conclusion: json["conclusion"],
      mainImageUrl: json["main_image_url"],
    );
  }

  Map<String, Object?> toJson() => {
        ProjectsFields.id: id,
        ProjectsFields.clientId: clientId,
        ProjectsFields.industryId: industryId,
        ProjectsFields.title: title,
        ProjectsFields.occasion: occasion,
        ProjectsFields.motto: motto,
        ProjectsFields.targetGroup: targetGroup,
        ProjectsFields.conclusion: conclusion,
        ProjectsFields.mainImageUrl: mainImageUrl,
      };
}
