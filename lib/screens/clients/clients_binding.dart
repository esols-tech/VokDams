import 'package:vokdams/import_packages.dart';

class ClientsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ClientsController());
  }
}
