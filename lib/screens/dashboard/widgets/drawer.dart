import 'package:vokdams/import_packages.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(36.0),
              child: Image.asset(logo),
            ),
            ListTile(
              leading: Iconify(
                Fluent.dark_theme_20_filled,
                color: Theme.of(context).iconTheme.color,
              ),
              title: const Text(
                "Dark Mode",
                style: TextStyle(fontSize: 18.0),
              ),
              trailing: Obx(
                () => Switch(
                  value: Get.find<GlobalController>().isDarkMode,
                  onChanged: Get.find<GlobalController>().updateThemeMode,
                ),
              ),
            ),
            ListTile(
              leading: Iconify(
                Ri.arrow_go_back_fill,
                color: Theme.of(context).iconTheme.color,
              ),
              title: const Text(
                "Back to Intro",
                style: TextStyle(fontSize: 18.0),
              ),
              onTap: () {
                Get.back();
                Get.toNamed(Routes.introScreen);
              },
            )
          ],
        ),
      ),
    );
  }
}
