import 'package:vokdams/import_packages.dart';

class TypesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TypesController());
  }
}
