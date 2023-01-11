import 'package:flutter/services.dart';
import 'package:vokdams/import_packages.dart';

class IntroductionController extends GetxController {
  // * constructor
  IntroductionController() : pageController = PageController(initialPage: 0);

  // * instances

  //* Use this variable to navigate the pages of Introduction PageView.
  final PageController pageController;

  // * observable instances.
  final Rx<int> _pageIndex = 1.obs;
  int get pageIndex => _pageIndex.value;

  // * methods
  @override
  void onInit() {
    super.onInit();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  onPageChanged(index) {
    // * if index is 6 then remove intro screens from stack and move to dashboard.
    if (index == 6) {
      Get.offNamed(Routes.dashboardScreen);
    }

    _pageIndex.value = index + 1;
  }
}
