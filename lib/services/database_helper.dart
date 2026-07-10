import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/item.dart';

// Questa classe si occupa di TUTTO ciò che riguarda il database:
// crearlo, aprirlo, e fare le operazioni CRUD (Create, Read, Update, Delete).
//
// Uso il pattern "singleton": significa che esiste una sola istanza
// di questa classe in tutta l'app, così non apriamo il database più volte.
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  // Se il database è già aperto lo riusa, altrimenti lo crea/apre.
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'lista_spesa.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Questa query viene eseguita solo la prima volta,
        // quando il database non esiste ancora.
        await db.execute('''
          CREATE TABLE items(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT NOT NULL,
            categoria TEXT NOT NULL,
            comprato INTEGER NOT NULL DEFAULT 0
          )
        ''');
      },
    );
  }

  // CREATE: aggiunge un nuovo articolo
  Future<int> insertItem(Item item) async {
    final db = await database;
    return await db.insert('items', item.toMap());
  }

  // READ: restituisce tutti gli articoli, ordinati per categoria
  Future<List<Item>> getItems() async {
    final db = await database;
    final maps = await db.query('items', orderBy: 'categoria, nome');
    return maps.map((map) => Item.fromMap(map)).toList();
  }

  // UPDATE: aggiorna un articolo esistente (es. quando spunto "comprato")
  Future<int> updateItem(Item item) async {
    final db = await database;
    return await db.update(
      'items',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  // DELETE: elimina un articolo dato il suo id
  Future<int> deleteItem(int id) async {
    final db = await database;
    return await db.delete('items', where: 'id = ?', whereArgs: [id]);
  }
}
