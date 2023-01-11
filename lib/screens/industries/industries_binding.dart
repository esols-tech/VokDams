import 'package:vokdams/import_packages.dart';

class IndustriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => IndustriesController());
  }
}
