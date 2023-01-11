import 'package:vokdams/import_packages.dart';

class BoxContainer extends StatelessWidget {
  const BoxContainer({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  final String text;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child:
          // Obx(() =>
          Container(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        decoration: BoxDecoration(
          // color: Get.find<GlobalController>().isDarkMode
          //     ? darkDeepBackground
          //     : white,
          color: Theme.of(context).primaryColor,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 36.0),
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              // * other text colors will be change automatically through ColorScheme.dark() or ColorScheme.light(), but here because we have a container with color that will become black on dark mode so the text color will not work here, that is why I am using it for just shortcut.
              color: Theme.of(context).iconTheme.color,
            ),
          ),
        ),
      ),
      // ),
    );
  }
}
