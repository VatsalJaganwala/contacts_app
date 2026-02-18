import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/contact_model.dart';

class DatabaseService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'contacts.db');

    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE contacts(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        phone TEXT NOT NULL,
        email TEXT,
        company TEXT,
        notes TEXT,
        isFavorite INTEGER,
        createdAt TEXT
      )
    ''');
  }

  Future<int> insertContact(ContactModel contact) async {
    final db = await database;
    return await db.insert('contacts', contact.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<ContactModel>> getAllContacts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('contacts', orderBy: 'createdAt DESC');

    return List.generate(maps.length, (i) {
      return ContactModel.fromJson(maps[i]);
    });
  }

  Future<ContactModel?> getContactById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('contacts', where: 'id = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return ContactModel.fromJson(maps.first);
    }
    return null;
  }

  Future<List<ContactModel>> getFavoriteContacts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'contacts',
      where: 'isFavorite = ?',
      whereArgs: [1],
      orderBy: 'createdAt DESC',
    );

    return List.generate(maps.length, (i) {
      return ContactModel.fromJson(maps[i]);
    });
  }

  Future<int> updateContact(ContactModel contact) async {
    final db = await database;
    return await db.update('contacts', contact.toJson(), where: 'id = ?', whereArgs: [contact.id]);
  }

  Future<int> deleteContact(int id) async {
    final db = await database;
    return await db.delete('contacts', where: 'id = ?', whereArgs: [id]);
  }
}
