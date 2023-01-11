import 'dart:developer';

import 'package:vokdams/import_packages.dart';

const String tableClients = 'clients';

class ClientFields {
  // static const List<String> values = [id, name];
  static const String id = "id";
  static const String name = "name";
}

class ClientDatabase {
  ClientDatabase._privateConstructor();

  static Database? _database;

  static final ClientDatabase _instance = ClientDatabase._privateConstructor();

  factory ClientDatabase() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;

    log("Local database initialized!");
    _database = await _initDB('clients.db');
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
CREATE TABLE $tableClients (
  ${ClientFields.id} $idType,
  ${ClientFields.name} $nameType
)
''');
  }

  Future<ClientData> create(ClientData client) async {
    final db = await _instance.database;

    final id = await db.insert(tableClients, client.toJson());
    return client.copy(id: id);
  }

  Future<List<ClientData>> readAllClients() async {
    final db = await _instance.database;

    final result = await db.query(tableClients);

    return result.map((json) => ClientData.fromJson(json)).toList();
  }

  Future<String> clearClientsTable() async {
    final db = await _instance.database;

    db.execute("DELETE FROM $tableClients");

    return "Clients table resets successfully!";
  }

  // Future<String> dropClientsTable() async {
  //   final db = await _instance.database;

  //   await db.execute("DROP TABLE IF EXISTS $tableClients");

  //   return "Clients table has been deleted!";
  // }

  Future close() async {
    final db = await _instance.database;

    db.close();
  }
}
