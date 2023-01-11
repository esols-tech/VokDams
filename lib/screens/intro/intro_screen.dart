import 'package:vokdams/import_packages.dart';

class IntroductionScreen extends GetView<IntroductionController> {
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        body: PageView(
          // * This page view direction is vertical and reverse is set to true, so if use swap it means move it up, so we want to skip the introduction screens.
          scrollDirection: Axis.vertical,
          onPageChanged: (index) {
            // * on index 6 it will move the home screen.
            controller.onPageChanged(6);
          },
          reverse: true,
          children: [
            Stack(
              children: [
                Center(
                  child: PageView(
                    controller: controller.pageController,
                    onPageChanged: controller.onPageChanged,
                    children: [
                      Center(child: Image.asset(introImage1)),
                      Center(child: Image.asset(introImage2)),
                      Center(child: Image.asset(introImage3)),
                      Center(child: Image.asset(introImage4)),
                      Center(child: Image.asset(introImage5)),
                      Center(child: Image.asset(introImage6)),
                      const SizedBox()
                    ],
                  ),
                ),
                Positioned(
                  bottom: 36,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                      decoration: BoxDecoration(
                        color: greyShade600,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Obx(
                        () => Text(
                          "${controller.pageIndex} OF 6",
                          style: const TextStyle(
                            color: white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}
