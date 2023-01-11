import 'package:vokdams/import_packages.dart';

class TypesScreen extends GetView<TypesController> {
  const TypesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          color: Colors.blue,
          onRefresh: () => controller.onRefresh(),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Obx(
              () => ListView.separated(
                itemCount: controller.projectsTypes.length,
                itemBuilder: (context, index) {
                  final projectType = controller.projectsTypes[index];

                  return BoxContainer(
                    text: projectType.name,
                    onTap: () {
                      Get.toNamed(
                        Routes.projectsScreen,
                        arguments: [Project.projectType, projectType.id],
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
