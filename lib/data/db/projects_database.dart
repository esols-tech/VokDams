import 'dart:developer';

import 'package:vokdams/import_packages.dart';

const String tableProjects = 'projects';

class ProjectsFields {
  static const String id = "id";
  static const String clientId = "client_id";
  static const String industryId = "industry_id";
  static const String projectsTypes = "projects_types";
  static const String title = "title";
  static const String occasion = "occasion";
  static const String motto = "motto";
  static const String targetGroup = "target_group";
  static const String implementation = "implementation";
  static const String conclusion = "conclusion";
  static const String mainImageUrl = "main_image_url";
  static const String optionalImagesUrls = "optional_images_urls";
  static const String optionalVideosUrls = "optional_videos_urls";
}

class ProjectDatabase {
  ProjectDatabase._privateConstructor();

  static Database? _database;

  static final ProjectDatabase _instance =
      ProjectDatabase._privateConstructor();

  factory ProjectDatabase() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;

    log("Local database initialized!");
    _database = await _initDB('projects.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: createDB);
  }

  Future createDB(Database db, int version) async {
    // * NOTE: SQFLITE IS NOT HANDLING JSONS AT THIS TIME, SO WE HAVE OPTION TO CREATE A SAPERATE TABLE FOR NESTED LISTS AND BIND THAT LIST'S DATA WITH EACH ROW OF MAIN TABLE.

    await db.execute(
      'CREATE TABLE types (_id INTEGER NOT NULL, project_type TEXT NOT NULL)',
    );

    await db.execute(
      'CREATE TABLE implementations (_id INTEGER NOT NULL, implementation TEXT NOT NULL)',
    );

    await db.execute(
      'CREATE TABLE optional_images_urls (_id INTEGER NOT NULL, optional_image_url TEXT NOT NULL)',
    );

    await db.execute(
      'CREATE TABLE optional_videos_urls (_id INTEGER NOT NULL, optional_video_url TEXT NOT NULL)',
    );

    await db.execute('''
CREATE TABLE $tableProjects (
  ${ProjectsFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
  ${ProjectsFields.clientId} INTEGER NOT NULL,
  ${ProjectsFields.industryId} INTEGER NOT NULL,
  ${ProjectsFields.title} TEXT NOT NULL,
  ${ProjectsFields.occasion} TEXT NOT NULL,
  ${ProjectsFields.motto} TEXT NOT NULL,
  ${ProjectsFields.targetGroup} TEXT NOT NULL,
  ${ProjectsFields.conclusion} TEXT NOT NULL,
  ${ProjectsFields.mainImageUrl} TEXT NOT NULL
)
''');
  }

  Future<String> create(ProjectData project) async {
    final db = await _instance.database;

    await _insertProjectsTypesToTheirOwnTable(
        db, project.id, project.projectsTypes);

    await _insertImplementationsToTheirOwnTable(
        db, project.id, project.implementation);

    await _insertOptionalImagesUrlsToTheirOwnTable(
        db, project.id, project.optionalImagesUrls);

    await _insertOptionalVideosUrlsToTheirOwnTable(
        db, project.id, project.optionalVideosUrls);

    final id = await db.insert(tableProjects, project.toJson());

    return "Insert project with Id: $id";
  }

  Future _insertProjectsTypesToTheirOwnTable(
      Database db, int projectId, List<dynamic> projectsTypes) async {
    for (var projectType in projectsTypes) {
      await db.insert(
        "types",
        {
          "_id": projectId,
          "project_type": projectType,
        },
      );
    }
  }

  Future _insertImplementationsToTheirOwnTable(
      Database db, int projectId, List<dynamic> implementations) async {
    for (var implementation in implementations) {
      await db.insert(
        "implementations",
        {
          "_id": projectId,
          "implementation": implementation,
        },
      );
    }
  }

  Future _insertOptionalImagesUrlsToTheirOwnTable(
      Database db, int projectId, List<dynamic> optionalImagesUrls) async {
    for (var optionalImageUrl in optionalImagesUrls) {
      await db.insert(
        "optional_images_urls",
        {
          "_id": projectId,
          "optional_image_url": optionalImageUrl,
        },
      );
    }
  }

  Future _insertOptionalVideosUrlsToTheirOwnTable(
      Database db, int projectId, List<dynamic> optionalVideosUrls) async {
    for (var optionalVideoUrl in optionalVideosUrls) {
      await db.insert(
        "optional_videos_urls",
        {
          "_id": projectId,
          "optional_video_url": optionalVideoUrl,
        },
      );
    }
  }

  Future<List<ProjectData>> readAllProjects(
    Project project,
    dynamic id, {
    int? projectId,
  }) async {
    final db = await _instance.database;

    // * store queryKey based on project, client_id, industry_id or id (for projects types)
    String queryKey = "";
    // * projects types are stored in a separate tables, based on the id, we will retrieve results from table and store in this list.
    List<Map<String, Object?>> matchedTypes = [];

    switch (project) {
      case Project.client:
        queryKey = ProjectsFields.clientId;
        break;
      case Project.industry:
        queryKey = ProjectsFields.industryId;
        break;
      case Project.projectType:
        queryKey = "id";
        matchedTypes =
            await db.query("types", where: "project_type = ?", whereArgs: [id]);
        break;
      default:
    }

    /*
      * if the project is Project.projectType then we have query for all matched types of results from projects types table and store the list of values to projects list.

      * if the project is other than Project.projectType then just simple query will give all results.
    */
    var projects = [];

    if (project == Project.projectType) {
      for (int i = 0; i < matchedTypes.length; i++) {
        projects.addAll(await db.query(
          tableProjects,
          where: "$queryKey = ?",
          whereArgs: [matchedTypes[i]["_id"].toString()],
        ));
      }
    } else {
      projects = await db.query(
        tableProjects,
        where: "$queryKey = ?",
        whereArgs: [id],
      );
    }

    List<ProjectData> projectsList = [];

    for (var i = 0; i < projects.length; i++) {
      ProjectData project = ProjectData.fromJsonLocalDatabase(projects[i]);

      project.projectsTypes = await _readAllProjectsTypes(db, project.id);

      project.implementation = await _readAllImplementations(db, project.id);

      project.optionalImagesUrls =
          await _readAllOptionalImagesUrls(db, project.id);

      project.optionalVideosUrls =
          await _readAllOptionalVideosUrls(db, project.id);

      projectsList.add(project);
    }

    return projectsList;
  }

  Future<List<dynamic>> _readAllProjectsTypes(
      Database db, int projectId) async {
    final projectsTypes = await db.query(
      "types",
      where: '"_id" = ?',
      whereArgs: [projectId],
    );

    return projectsTypes.map((json) => json["project_type"]).toList();
  }

  Future<List<dynamic>> _readAllImplementations(
      Database db, int projectId) async {
    final implementations = await db.query(
      "implementations",
      where: '"_id" = ?',
      whereArgs: [projectId],
    );

    return implementations.map((json) => json["implementation"]).toList();
  }

  Future<List<dynamic>> _readAllOptionalImagesUrls(
      Database db, int projectId) async {
    final optionalImagesUrls = await db.query(
      "optional_images_urls",
      where: '"_id" = ?',
      whereArgs: [projectId],
    );

    return optionalImagesUrls
        .map((json) => json["optional_image_url"])
        .toList();
  }

  Future<List<dynamic>> _readAllOptionalVideosUrls(
      Database db, int projectId) async {
    final optionalVideosUrls = await db.query(
      "optional_videos_urls",
      where: '"_id" = ?',
      whereArgs: [projectId],
    );

    return optionalVideosUrls
        .map((json) => json["optional_video_url"])
        .toList();
  }

  Future<String> clearProjectsTable() async {
    final db = await _instance.database;

    db.execute("DELETE FROM $tableProjects");
    db.execute("DELETE FROM types");
    db.execute("DELETE FROM implementations");
    db.execute("DELETE FROM optional_images_urls");
    db.execute("DELETE FROM optional_videos_urls");

    return "Projects table resets successfully!";
  }

  Future<String> dropProjectsTable() async {
    final db = await _instance.database;

    await db.execute("DROP TABLE IF EXISTS $tableProjects");
    db.execute("DROP TABLE IF EXISTS types");
    db.execute("DROP TABLE IF EXISTS implementations");
    db.execute("DROP TABLE IF EXISTS optional_images_urls");
    db.execute("DROP TABLE IF EXISTS optional_videos_urls");

    return "Projects table has been deleted!";
  }

  Future close() async {
    final db = await _instance.database;

    db.close();
  }
}
