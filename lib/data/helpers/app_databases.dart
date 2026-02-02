import 'package:sqflite/sqflite.dart';

class AppDataBase {
  static Database? _db;

  static Future<Database> get dataBase async {
    if (_db != null) {
      return _db!;
    }
    final databasesPath = await getDatabasesPath();
    final path = '$databasesPath/movies.db';

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE Movies (
            imdbID TEXT UNIQUE,
            isFavorite INTEGER
          )
        ''');
      },
    );
    return _db!;
  }
}