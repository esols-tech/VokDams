import 'package:vokdams/import_packages.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        endDrawer: const DrawerWidget(),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child:
              // Obx(() =>
              AppBar(
            elevation: 1,
            // backgroundColor: Get.find<GlobalController>().isDarkMode
            //     ? darkAppbarColor
            //     : white,
            iconTheme: Theme.of(context).iconTheme,
            leading: Padding(
              padding: const EdgeInsets.only(left: 36.0),
              child: Image.asset(logo),
            ),
            leadingWidth: 1000,
          ),
          // ),
        ),
        body: SafeArea(
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: controller.pageController,
            onPageChanged: controller.onPageChanged,
            children: const [
              ClientsScreen(),
              IndustriesScreen(),
              TypesScreen(),
            ],
          ),
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            iconSize: 30.0,
            selectedFontSize: 14.0,
            // backgroundColor: Get.find<GlobalController>().isDarkMode
            //     ? darkDeepBackground
            //     : white,
            unselectedFontSize: 14.0,
            selectedItemColor: red,
            unselectedItemColor: greyShade400,
            // selectedLabelStyle: helveticaNeueWithHalfWhite,
            // unselectedLabelStyle: helveticaNeueWithHalfWhite,
            // selectedIconTheme: const IconThemeData(color: red),
            type: BottomNavigationBarType.fixed,
            currentIndex: controller.selectedIndex,
            items: List.generate(
              3,
              (index) => BottomNavigationBarItem(
                label: controller.bottomBarItemsLabels[index],
                icon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Iconify(
                    controller.icons[index],
                    size: 36.0,
                    color:
                        controller.selectedIndex == index ? red : greyShade400,
                  ),
                ),
              ),
            ),
            onTap: controller.onBottomBarItemTap,
          ),
        ),
      ),
    );
  }
}
