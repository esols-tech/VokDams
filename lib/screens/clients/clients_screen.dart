import 'package:vokdams/import_packages.dart';

class ClientsScreen extends GetView<ClientsController> {
  const ClientsScreen({Key? key}) : super(key: key);

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
                itemCount: controller.clients.length,
                itemBuilder: (context, index) {
                  final client = controller.clients[index];

                  return BoxContainer(
                      text: client.name,
                      onTap: () {
                        Get.toNamed(
                          Routes.projectsScreen,
                          arguments: [Project.client, client.id],
                        );
                      });
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
