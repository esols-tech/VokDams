import 'dart:developer';

import 'package:vokdams/import_packages.dart';

const String tableProjectsTypes = 'projects_types';

class ProjectTypeFields {
  static const String id = "id";
  static const String name = "name";
}

class ProjectTypeDatabase {
  ProjectTypeDatabase._privateConstructor();

  static Database? _database;

  static final ProjectTypeDatabase _instance =
      ProjectTypeDatabase._privateConstructor();

  factory ProjectTypeDatabase() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;

    log("Local database initialized!");
    _database = await _initDB('projects_types.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: createDB);
  }

  Future createDB(Database db, int version) async {
    const String idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const String nameType = "TEXT NOT NULL";

    await db.execute('''
CREATE TABLE $tableProjectsTypes (
  ${ClientFields.id} $idType,
  ${ClientFields.name} $nameType
)
''');
  }

  Future<ProjectTypeData> create(ProjectTypeData projectType) async {
    final db = await _instance.database;

    final id = await db.insert(tableProjectsTypes, projectType.toJson());
    return projectType.copy(id: id);
  }

  Future<List<ProjectTypeData>> readAllProjectsTypes() async {
    final db = await _instance.database;

    final result = await db.query(tableProjectsTypes);

    return result.map((json) => ProjectTypeData.fromJson(json)).toList();
  }

  Future<String> clearProjectsTypesTable() async {
    final db = await _instance.database;

    db.execute("DELETE FROM $tableProjectsTypes");

    return "Projects types table resets successfully!";
  }

  Future close() async {
    final db = await _instance.database;

    db.close();
  }
}
