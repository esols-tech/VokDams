import 'package:vokdams/import_packages.dart';

class IndustriesController extends GetxController {
  // * instances
  final IndustryDatabase _industryDatabase = IndustryDatabase();

  // * observable instances
  final RxList<IndustryData> _industries = <IndustryData>[].obs;
  List<IndustryData> get industries => _industries;

  // * methods
  @override
  void onInit() async {
    super.onInit();

    getIndustriesFromLocalDatabase();
  }

  getIndustriesFromLocalDatabase() async {
    _industries.value = await _industryDatabase.readAllIndustries();
    _industries.sort((a, b) => a.name.compareTo(b.name));
  }

  Future<void> onRefresh() async {
    await Get.find<GlobalController>()
        .retrieveAndStoreIndustriesToLocalDatabase();
    getIndustriesFromLocalDatabase();
  }
}
