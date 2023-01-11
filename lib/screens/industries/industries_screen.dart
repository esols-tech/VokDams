import 'package:vokdams/import_packages.dart';

class IndustriesScreen extends GetView<IndustriesController> {
  const IndustriesScreen({Key? key}) : super(key: key);

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
                itemCount: controller.industries.length,
                itemBuilder: (context, index) {
                  final industry = controller.industries[index];

                  return BoxContainer(
                    text: industry.name,
                    onTap: () {
                      Get.toNamed(
                        Routes.projectsScreen,
                        arguments: [Project.industry, industry.id],
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
