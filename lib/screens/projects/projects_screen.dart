import 'package:vokdams/import_packages.dart';

class ProjectsScreen extends GetView<ProjectsController> {
  const ProjectsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          // backgroundColor:
          //     Get.find<GlobalController>().isDarkMode ? darkAppbarColor : white,
          iconTheme: Theme.of(context).iconTheme,
          title: Image.asset(logo, width: 250.0),
        ),
        body: RefreshIndicator(
          color: Colors.blue,
          onRefresh: () => controller.onRefresh(),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Obx(
              () => ListView.separated(
                itemCount: controller.projects.length,
                itemBuilder: (context, index) {
                  ProjectData project = controller.projects[index];

                  return BoxContainer(
                    text: project.title,
                    onTap: () {
                      Get.toNamed(
                        Routes.projectDetailScreen,
                        arguments: project,
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 16.0);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
