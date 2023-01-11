import 'package:vokdams/import_packages.dart';

class ClientsController extends GetxController {
  // * instances
  final ClientDatabase _clientDatabase = ClientDatabase();

  // * observable instances
  final RxList<ClientData> _clients = <ClientData>[].obs;
  List<ClientData> get clients => _clients;

  // * methods
  @override
  void onInit() async {
    super.onInit();

    getClientsFromLocalDatabase();
  }

  getClientsFromLocalDatabase() async {
    _clients.value = await _clientDatabase.readAllClients();
    _clients.sort((a, b) => a.name.compareTo(b.name));
  }

  Future<void> onRefresh() async {
    await Get.find<GlobalController>().retrieveAndStoreClientsToLocalDatabase();
    getClientsFromLocalDatabase();
  }
}
