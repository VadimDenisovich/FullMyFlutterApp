import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/word_card.dart';

/// Класс для бд
///
/// Инициализирует базу данных внутри себя, чтобы не создавать дополнительных
/// экземпляров. Принцип синглтон.
/// Обращаемся непосредственно к классу.
/// Вот так: Carddatabase.instance.{method()}
class CardDatabase {
  /// Создаем экземлпяр класса с помощью его приватного конструктора,
  /// который не будет доступен извне.
  /// Статическая переменная - общая для всех экземпляров класса,
  /// она принадлежит классу.
  static final CardDatabase instance = CardDatabase._init();

  /// Приватное поле типа Database, которое будет хранить в
  /// себе едиственный экземпляр базы данных
  /// Это поле также статитическое и принадлежит классу, а не экземпляру.
  static Database? _database;

  /// Определяем приватный конструктор
  /// Это предотвращает создание новых экземпляров из др. частей кода
  /// Поскольку экземпляр можно создать только внутри самого класса
  /// Т.к он приватный
  CardDatabase._init();

  /// Используем getter, потому что к переменной _database нельзя
  /// будет обратиться из другого файла
  Future<Database> get database async {
    /// Если db уже инициализирована, то возвращаем имеющуюся
    if (_database != null) return _database!;

    /// Если не инициализирована, то инициализируем и возвращаем
    /// базу данных
    _database = await _initDB('cards.db');
    return _database!;
  }

  /// Инициализирует базу данных, получает на вход название бд
  Future<Database> _initDB(String filePath) async {
    /// Возвращает путь к директории, где хранятся бд
    final dbPath = await getDatabasesPath();

    /// Получаем путь, по которому должна появится наша бд
    final path = join(dbPath, filePath);

    /// Открывает бд по указанному пути, указывает версию бд,
    /// и запускает ф-цию обратного вызова, которая срабатывает
    /// при первом запуске бд
    ///
    /// Почему return, а потом await?
    /// await - потому что мы ожидаем завершения асинхронной операции открытия
    /// return - потому что возвращаем экземпляр открытой бд
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  /// Отвечает за создание таблиц при первом создании бд
  /// Получает на вход db, где будет происходит создание таблицы
  /// и версию бд
  Future _createDB(Database db, int version) async {
    /// id - первичный целочисленный ключ
    const idType = 'INTEGER PRIMARY KEY';

    /// текстовые значения, не могут быть NULL
    const textType = 'TEXT NOT NULL';

    /// Выполняет sql-запрос
    ///
    /// Создает таблицу cards со столбцами id, first, second
    await db.execute('''
    CREATE TABLE cards (
    id $idType,
    first $textType,
    second $textType
    )
    ''');
  }

  /// Добавляем карточку в таблицу 'cards'
  Future<int> create(Map<String, dynamic> card) async {
    final db = await instance.database;
    return await db.insert('cards', card);
  }

  /// Получаем список всех карточек с бд
  Future<List<WordCard>> getCards() async {
    final db = await instance.database;

    /// db.query - возвращает список словарей, где каждый словарь - отдельная
    /// карточка.
    /// Каждый ключ имени столбца, а значение - значение этого столбца в строке.
    final List<Map<String, dynamic>> cards = await db.query('cards');
    return List.generate(cards.length, (int index) {
      return WordCard.fromMap(cards[index]);
    });
  }

  /// Очищаем всю бд
  Future clear() async {
    final db = await instance.database;
    await db.delete('cards');
  }

  /// Удаляем конкретную карточку с бд
  Future deleteCard(WordCard card) async {
    final db = await instance.database;

    /// Удаляем конкретную карточку по опред. айдишнику, данному в списке
    /// Как это работает?
    /// `?` в строке явл-ся плейсхолдером для значения из списка `whereArgs`
    ///
    /// Вот в какой SQL запрос это переводится
    /// `DELETE FROM cards WHERE id = 123;`
    await db.delete('cards', where: 'id = ?', whereArgs: [card.id]);
  }
}
