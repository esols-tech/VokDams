import 'package:flutter/services.dart';

import 'package:vokdams/import_packages.dart';

class DashboardController extends GetxController {
  // * set initial index 0 so the dashboard starts from clients screen.
  DashboardController() : pageController = PageController(initialPage: 0);

  // * instances
  //* Use this variable to navigate the pages of PageView.
  final PageController pageController;

  // * data variables
  final List<String> icons = [
    Mdi.tag,
    SimpleLineIcons.globe,
    Ph.squares_four_fill,
  ];

  final List<String> bottomBarItemsLabels = [
    "Clients",
    "Industries",
    "Type of Projects",
  ];

  // * observable instances
  final _selectedIndex = 0.obs;
  int get selectedIndex => _selectedIndex.value;
  set bottomBarSelectedItemIndex(value) => _selectedIndex.value = value;

  final Rx<String> _appbarTitle = "Trades".obs;
  String get appbarTitle => _appbarTitle.value;

  // * methods
  @override
  void onInit() {
    super.onInit();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  //* Call this method inside PageView, whenever page changes.
  void onPageChanged(int index) {
    // * check page index and update the app bar title accordingly.
    switch (index) {
      case 0:
        _appbarTitle.value = "Trades";
        break;
      case 1:
        _appbarTitle.value = "History";
        break;
      case 2:
        _appbarTitle.value = "Results";
        break;
      default:
    }
  }

  onBottomBarItemTap(index) {
    _selectedIndex.value = index;
    pageController.jumpToPage(index);
  }
}
