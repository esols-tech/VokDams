import 'package:vokdams/import_packages.dart';


abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: Routes.initialScreen,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.introScreen,
      page: () => const IntroductionScreen(),
      binding: IntroductionBinding(),
    ),
    GetPage(
      name: Routes.dashboardScreen,
      page: () => const DashboardScreen(),
      bindings: [
        DashboardBinding(),
        ClientsBinding(),
        IndustriesBinding(),
        TypesBinding(),
      ],
    ),
    GetPage(
      name: Routes.projectsScreen,
      page: () => const ProjectsScreen(),
      binding: ProjectsBinding(),
    ),
    GetPage(
      name: Routes.projectDetailScreen,
      page: () => const ProjectDetailScreen(),
      binding: ProjectDetailBinding(),
    ),
  ];
}
