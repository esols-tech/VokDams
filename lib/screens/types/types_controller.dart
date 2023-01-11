import 'package:vokdams/import_packages.dart';

class TypesController extends GetxController {
  // * instances
  final ProjectTypeDatabase _projectTypeDatabase = ProjectTypeDatabase();

  // * observable instances
  final RxList<ProjectTypeData> _projectsTypes = <ProjectTypeData>[].obs;
  List<ProjectTypeData> get projectsTypes => _projectsTypes;

  // * methods
  @override
  void onInit() async {
    super.onInit();

    getProjectsTypesFromLocalDatabase();
  }

  getProjectsTypesFromLocalDatabase() async {
    _projectsTypes.value = await _projectTypeDatabase.readAllProjectsTypes();
    _projectsTypes.sort((a, b) => a.name.compareTo(b.name));
  }

  Future<void> onRefresh() async {
    await Get.find<GlobalController>()
        .retrieveAndStoreProjectsTypesToLocalDatabase();
    getProjectsTypesFromLocalDatabase();
  }
}
