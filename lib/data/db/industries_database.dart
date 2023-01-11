import 'dart:developer';

import 'package:vokdams/import_packages.dart';

const String tableIndustries = 'industries';

class IndustryFields {
  // static const List<String> values = [id, name];
  static const String id = "id";
  static const String name = "name";
}

class IndustryDatabase {
  IndustryDatabase._privateConstructor();

  static Database? _database;

  static final IndustryDatabase _instance =
      IndustryDatabase._privateConstructor();

  factory IndustryDatabase() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;

    log("Local database initialized!");
    _database = await _initDB('industries.db');
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
CREATE TABLE $tableIndustries (
  ${ClientFields.id} $idType,
  ${ClientFields.name} $nameType
)
''');
  }

  Future<IndustryData> create(IndustryData industry) async {
    final db = await _instance.database;

    final id = await db.insert(tableIndustries, industry.toJson());
    return industry.copy(id: id);
  }

  Future<List<IndustryData>> readAllIndustries() async {
    final db = await _instance.database;

    final result = await db.query(tableIndustries);

    return result.map((json) => IndustryData.fromJson(json)).toList();
  }

  Future<String> clearIndustriesTable() async {
    final db = await _instance.database;

    db.execute("DELETE FROM $tableIndustries");

    return "Industries table resets successfully!";
  }

  Future close() async {
    final db = await _instance.database;

    db.close();
  }
}
