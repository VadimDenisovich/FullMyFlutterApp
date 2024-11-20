import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/word_card.dart';

class CardDatabase {
  static final CardDatabase instance = CardDatabase._init();
  static Database? _database;
  CardDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('cards.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE cards (
    id $idType,
    first $textType,
    second $textType
    )
    ''');
  }

  Future<int> create(Map<String, dynamic> card) async {
    final db = await instance.database;
    return await db.insert('cards', card);
  }

  Future<List<WordCard>> getCards() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> cards = await db.query('cards');
    return List.generate(cards.length, (int index) {
      return WordCard.fromMap(cards[index]);
    });
  }

  Future clear() async {
    final db = await instance.database;
    await db.delete('cards');
  }

  Future deleteCard(WordCard card) async {
    final db = await instance.database;
    await db.delete('cards', where: 'id = ?', whereArgs: [card.id]);
  }
}
