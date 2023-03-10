import 'package:sqflite/sqflite.dart';

import '../model/restaurants.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _tblFavourite = 'favourite';

  Future<Database> _initDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase('$path/restaurant.db', onCreate: (db, version) async {
      await db.execute('''CREATE TABLE $_tblFavourite(
             id TEXT PRIMARY KEY,
             name TEXT,
             description TEXT,
             pictureId TEXT,
             city TEXT,
             rating REAL)''');
    }, version: 1);
    return db;
  }

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initDb();
    } else {
      null;
    }

    return _database;
  }

  Future<void> insertRestaurant(Restaurant restaurant) async {
    final db = await database;
    await db?.insert(_tblFavourite, restaurant.toJson());
  }

  Future<List<Restaurant>> getFavorite() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tblFavourite);

    return results.map((res) => Restaurant.fromJson(res)).toList();
  }

  Future<Map> getRestaurantById(String id) async {
    final db = await database;
    List<Map<String, dynamic>>? results = await db?.query(
      _tblFavourite,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results?.isNotEmpty == true) {
      return results?.first ?? {};
    } else {
      return {};
    }
  }

  Future<void> deleteRestaurant(String id) async {
    final db = await database;
    await db?.delete(
      _tblFavourite,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
