import 'package:vokdams/import_packages.dart';

class IntroductionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(IntroductionController());
  }
}
