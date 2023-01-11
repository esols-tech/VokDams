import 'package:vokdams/import_packages.dart';

class SplashController extends GetxController {
  // * methods
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 3), () {
      Get.toNamed(Routes.introScreen);
    });
  }
}
