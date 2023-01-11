import 'package:iconify_flutter/icons/ci.dart';
import 'package:vokdams/import_packages.dart';

class DataPage extends GetView<ProjectDetailController> {
  const DataPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(56.0, 56.0, 56.0, 0.0),
      child: ListView(
        children: [
          Text(
            controller.projectData.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
            ),
          ),
          const SizedBox(height: 24.0),
          Container(
            padding: const EdgeInsets.fromLTRB(36.0, 24.0, 36.0, 24.0),
            decoration: BoxDecoration(
              // color: Get.find<GlobalController>().isDarkMode
              //     ? darkBackground
              //     : white,
              color: Theme.of(context).primaryColor,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeadingText(heading: "Occasion"),
                  Description(description: controller.projectData.occasion),
                  const HeadingText(heading: "Motto"),
                  Description(description: controller.projectData.motto),
                  const HeadingText(heading: "Target Group"),
                  Description(description: controller.projectData.targetGroup),
                  const HeadingText(heading: "Implementation"),
                  ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.projectData.implementation.length,
                    itemBuilder: (context, index) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Iconify(Ci.dot_03_m),
                          ),
                          Flexible(
                            child: Text(
                              controller.projectData.implementation[index],
                              style: const TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 16.0);
                    },
                  ),
                  const SizedBox(height: 30.0),
                  const HeadingText(heading: "Conclusion"),
                  Description(description: controller.projectData.conclusion),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Description extends StatelessWidget {
  const Description({
    Key? key,
    required this.description,
  }) : super(key: key);

  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Text(
        description,
        style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
      ),
    );
  }
}

class HeadingText extends StatelessWidget {
  const HeadingText({
    Key? key,
    required this.heading,
  }) : super(key: key);

  final String heading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Text(
        heading,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
      ),
    );
  }
}
