import 'package:vokdams/import_packages.dart';

enum Project { client, industry, projectType }

class ProjectsController extends GetxController {
  // * GetX instances
  final Project _project = Get.arguments[0];
  final int _id = Get.arguments[1];

  // * instances
  final ProjectDatabase _projectDatabase = ProjectDatabase();

  // * observable instances
  final RxList<ProjectData> _projects = <ProjectData>[].obs;
  List<ProjectData> get projects => _projects;

  // * methods
  @override
  void onInit() async {
    super.onInit();

    getProjectsFromLocalDatabase();
  }

  getProjectsFromLocalDatabase() async {
    _projects.value = await _projectDatabase.readAllProjects(_project, _id);
    _projects
        .sort((a, b) => a.title.toUpperCase().compareTo(b.title.toUpperCase()));
  }

  Future<void> onRefresh() async {
    await Get.find<GlobalController>()
        .retrieveAndStoreProjectsToLocalDatabase();
    getProjectsFromLocalDatabase();
  }
}
