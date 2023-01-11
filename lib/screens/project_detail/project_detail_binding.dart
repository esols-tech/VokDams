import 'package:vokdams/import_packages.dart';

class ProjectDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProjectDetailController());
  }
}
