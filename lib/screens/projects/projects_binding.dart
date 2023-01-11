import 'package:vokdams/import_packages.dart';

class ProjectsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProjectsController());
  }
}
