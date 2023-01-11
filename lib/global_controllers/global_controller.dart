import 'dart:developer';

import 'package:vokdams/import_packages.dart';

class GlobalController extends GetxController {
  GlobalController(this.context);

  // * instances
  final box = GetStorage();
  late BuildContext context;
  final ClientProvider _clientProvider = ClientProvider();
  final ClientDatabase _clientDatabase = ClientDatabase();
  final IndustryProvider _industryProvider = IndustryProvider();
  final IndustryDatabase _industryDatabase = IndustryDatabase();
  final ProjectTypeProvider _projectTypeProvider = ProjectTypeProvider();
  final ProjectTypeDatabase _projectTypeDatabase = ProjectTypeDatabase();
  final ProjectDatabase _projectDatabase = ProjectDatabase();
  final ProjectProvider _projectProvider = ProjectProvider();

  // * observable instances
  final Rx<ThemeMode> _themeMode = ThemeMode.system.obs;
  bool get isDarkMode => _themeMode.value == ThemeMode.dark;
  void updateThemeMode(isDarkMode) {
    Get.changeThemeMode(isDarkMode ? ThemeMode.dark : ThemeMode.light);
    isDarkMode
        ? _themeMode.value = ThemeMode.dark
        : _themeMode.value = ThemeMode.light;
  }

  // * methods
  @override
  void onInit() async {
    super.onInit();

    if (await InternetConnectionChecker().hasConnection) {
      log("Have internet connection");

      // * this will only be called if the initialDataLoaded value will null, and it will be null only first time the app install.

      box.writeIfNull(initialDataLoaded, false);

      // * first time it will be false, because the initial data will not be downloaded. After downloading data and storing it to local storage we do not want to do that again and again when user open the app.
      if (!box.read(initialDataLoaded)) {
        // showLoadingIndicator(
        //     message: "Fetching the data from server. Please wait!");

        retrieveAndStoreClientsToLocalDatabase();
        retrieveAndStoreIndustriesToLocalDatabase();
        retrieveAndStoreProjectsTypesToLocalDatabase();
        retrieveAndStoreProjectsToLocalDatabase();

        // * hide the loading indicator.
        // Get.back();

        box.write(initialDataLoaded, true);
      }
    } else {
      log("Do not have internet connection");
    }
  }

  Future<void> retrieveAndStoreClientsToLocalDatabase() async {
    // * get the clients from the server and store in the local database.
    final List<ClientData> clients = await getClients();

    // * clear the old clients data from table.
    _clientDatabase.clearClientsTable();

    // * store the new clients data to local database.
    final response = await storeClientsToLocalDatabase(clients);

    log(response);
  }

  Future<List<ClientData>> getClients() async {
    // * get clients
    final getClientsResult = await _clientProvider.getClients();

    if (getClientsResult is String) {
      log("get clients result");
      log(getClientsResult.toString());

      return [];
    } else {
      ClientModel clientModel = getClientsResult;

      return clientModel.data;
    }
  }

  Future<String> storeClientsToLocalDatabase(List<ClientData> clients) async {
    for (ClientData client in clients) {
      await _clientDatabase.create(client);
    }

    return "${clients.length} Clients' records inserted into local database.";
  }

  Future<void> retrieveAndStoreIndustriesToLocalDatabase() async {
    // * get the industries from the server and store in the local database.
    final List<IndustryData> industries = await getIndustries();

    // * clear the old industies data from table.
    _industryDatabase.clearIndustriesTable();

    // * store the new industries data to local database.
    final response = await storeIndustriesToLocalDatabase(industries);

    log(response);
  }

  Future<List<IndustryData>> getIndustries() async {
    // * get industries
    final getIndustriesResult = await _industryProvider.getIndustries();

    if (getIndustriesResult is String) {
      log("get industries result");
      log(getIndustriesResult.toString());

      return [];
    } else {
      IndustryModel industryModel = getIndustriesResult;

      return industryModel.data;
    }
  }

  Future<String> storeIndustriesToLocalDatabase(
      List<IndustryData> industries) async {
    for (IndustryData industry in industries) {
      await _industryDatabase.create(industry);
    }

    return "${industries.length} Industries' records inserted into local database.";
  }

  Future<void> retrieveAndStoreProjectsTypesToLocalDatabase() async {
    // * get the projects types from the server and store in the local database.
    final List<ProjectTypeData> projectsTypes = await getProjectsTypes();

    // * clear the old projects types data from table.
    _projectTypeDatabase.clearProjectsTypesTable();

    // * store the new projects types data to local database.
    final response = await storeProjectsTypesToLocalDatabase(projectsTypes);

    log(response);
  }

  Future<List<ProjectTypeData>> getProjectsTypes() async {
    // * get projects types
    final getProjectsTypesResult =
        await _projectTypeProvider.getProjectsTypes();

    if (getProjectsTypesResult is String) {
      log("get projects types result");
      log(getProjectsTypesResult.toString());

      return [];
    } else {
      ProjectTypeModel projectTypeModel = getProjectsTypesResult;

      return projectTypeModel.data;
    }
  }

  Future<String> storeProjectsTypesToLocalDatabase(
      List<ProjectTypeData> projectsTypes) async {
    for (ProjectTypeData projectType in projectsTypes) {
      await _projectTypeDatabase.create(projectType);
    }

    return "${projectsTypes.length} Projects Types' records inserted into local database.";
  }

  Future<void> retrieveAndStoreProjectsToLocalDatabase() async {
    // * get the projects from the server and store in the local database.
    final List<ProjectData> projects = await getProjects();

    // * clear the old projects data from table.
    _projectDatabase.clearProjectsTable();

    // * store the new projects data to local database.
    final response = await storeProjectsToLocalDatabase(projects);

    log(response);
  }

  Future<List<ProjectData>> getProjects() async {
    final response = await _projectProvider.getProjects();

    if (response is ProjectModel) {
      ProjectModel projectModel = response;

      return projectModel.data;
    } else {
      log(response);
      return [];
    }
  }

  Future<String> storeProjectsToLocalDatabase(
      List<ProjectData> projects) async {
    for (ProjectData project in projects) {
      await _projectDatabase.create(project);
    }

    return "${projects.length} Projects' records inserted into local database.";
  }

  showLoadingIndicator({String? message}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => message == null
          ? const Center(
              child:
                  CircularProgressIndicator(color: Colors.blue), // change color
            )
          : Center(
              child: Column(
                children: [
                  const CircularProgressIndicator(color: Colors.blue),
                  const SizedBox(height: 16.0),
                  Text(
                    message,
                    style: const TextStyle(color: Colors.blue),
                  )
                ],
              ), // change color
            ),
    );
  }

  @override
  void onClose() {
    _clientDatabase.close();
    _industryDatabase.close();
    _projectTypeDatabase.close();
    _projectDatabase.close();
    super.onClose();
  }
}
