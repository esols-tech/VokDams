import 'package:vokdams/import_packages.dart';

class ProjectDetailController extends GetxController {
  // * constructor
  ProjectDetailController() : pageController = PageController(initialPage: 0);

  // * GetX instances
  final ProjectData projectData = Get.arguments;

  // * instances

  //* Use this variable to navigate the pages of Introduction PageView.
  final PageController pageController;

  // * observable instances.
  final Rx<int> _pageIndex = 1.obs;
  int get pageIndex => _pageIndex.value;

  // * methods
  onPageChanged(index) {
    _pageIndex.value = index + 1;
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
