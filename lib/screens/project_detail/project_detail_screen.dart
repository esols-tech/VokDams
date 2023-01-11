import 'package:vokdams/import_packages.dart';

class ProjectDetailScreen extends GetView<ProjectDetailController> {
  const ProjectDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Get.find<GlobalController>().isDarkMode
        //     ? darkDeepBackground
        //     : lightBackground,
        appBar: AppBar(
          elevation: 1,
          // backgroundColor:
          //     Get.find<GlobalController>().isDarkMode ? darkAppbarColor : white,
          iconTheme: Theme.of(context).iconTheme,
          title: Image.asset(logo, width: 250.0),
        ),
        body: Stack(
          children: [
            Center(
              child: PageView(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                children: List.generate(
                  (controller.projectData.optionalImagesUrls.length +
                      controller.projectData.optionalVideosUrls.length +
                      2),
                  (index) {
                    int imagesLenght =
                        controller.projectData.optionalImagesUrls.length;

                    if (index == 0) {
                      return const ImagePage();
                    } else if (index == 1) {
                      return const DataPage();
                    } else if (index < imagesLenght + 2) {
                      return CachedNetworkImage(
                        imageUrl: controller
                            .projectData.optionalImagesUrls[index - 2],
                        placeholder: (context, url) => const Center(
                            child:
                                CircularProgressIndicator(color: Colors.blue)),
                        errorWidget: (context, url, error) =>
                            const Center(child: Icon(Icons.error)),
                      );
                    } else {
                      BetterPlayerDataSource betterPlayerDataSource =
                          BetterPlayerDataSource(
                        BetterPlayerDataSourceType.network,
                        controller.projectData
                            .optionalVideosUrls[index - imagesLenght - 2],
                        cacheConfiguration: BetterPlayerCacheConfiguration(
                          useCache: true,
                          preCacheSize: 100 * 1024 * 1024,
                          maxCacheSize: 100 * 1024 * 1024,
                          maxCacheFileSize: 100 * 1024 * 1024,
                          // * Android only option to use cached video between app sessions
                          key: "testCacheKey $index",
                        ),
                      );
                      return AspectRatio(
                        aspectRatio: 16 / 9,
                        child: BetterPlayer(
                          controller: BetterPlayerController(
                            const BetterPlayerConfiguration(
                              aspectRatio: 16 / 9,
                              autoDispose: false,
                            ),
                            betterPlayerDataSource: betterPlayerDataSource,
                          )..preCache(betterPlayerDataSource),
                        ),
                      );
                    }
                  },
                ),
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
                      // * 2 here represents, 1 the title page with image + 1 text page.
                      "${controller.pageIndex} OF ${2 + controller.projectData.optionalImagesUrls.length + controller.projectData.optionalVideosUrls.length}",
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
      ),
    );
  }
}

class ImagePage extends GetView<ProjectDetailController> {
  const ImagePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(56.0),
              child: Text(
                controller.projectData.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
            ),
            CachedNetworkImage(
              imageUrl: controller.projectData.mainImageUrl,
              placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(color: Colors.blue)),
              errorWidget: (context, url, error) =>
                  const Center(child: Icon(Icons.error)),
            ),
            const SizedBox(height: 130.0),
          ],
        ),
      ),
    );
  }
}
