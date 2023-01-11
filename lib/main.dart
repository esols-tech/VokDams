import 'package:responsive_framework/responsive_framework.dart';
import 'package:vokdams/import_packages.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
//testing
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      onInit: () {
        Get.put(GlobalController(context));
      },
      title: 'VOK Dams',
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      builder: (context, widget) {
        return ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget!),
          maxWidth: 1200,
          minWidth: 480,
          defaultName: MOBILE,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(320,
                name: MOBILE, scaleFactor: 0.9),
            const ResponsiveBreakpoint.resize(480, name: MOBILE),
            const ResponsiveBreakpoint.resize(600, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(850, name: TABLET),
            const ResponsiveBreakpoint.resize(1080, name: DESKTOP),
          ],
        );
      },
      getPages: AppPages.pages,
      initialRoute: Routes.initialScreen,
    );
  }
}
