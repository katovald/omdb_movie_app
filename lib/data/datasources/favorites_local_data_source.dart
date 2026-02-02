import 'package:sqflite/sqflite.dart';

import '../helpers/app_databases.dart';

abstract class FavoritesLocalDataSource {
  Future<void> addFavorite(String movieId);
  Future<void> removeFavorite(String movieId);
  Future<bool> isFavorite(String movieId);
  Future<List<String>> getAllFavorites();
}

class FavoritesLocalDataSourceImpl implements FavoritesLocalDataSource{
  @override
  Future<void> addFavorite(String movieId) async {
    final db = await AppDataBase.dataBase;
    await db.insert(
      'Movies',
      {'imdbID': movieId, 'isFavorite': 1},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> removeFavorite(String movieId) async {
    final db = await AppDataBase.dataBase;
    await db.delete(
      'Movies',
      where: 'imdbID = ?',
      whereArgs: [movieId],
    );
  }

  @override
  Future<bool> isFavorite(String movieId) async {
    final db = await AppDataBase.dataBase;
    final result = await db.query(
      'Movies',
      where: 'imdbID = ? AND isFavorite = ?',
      whereArgs: [movieId, 1],
    );
    return result.isNotEmpty;
  }

  @override
  Future<List<String>> getAllFavorites() async {
    final db = await AppDataBase.dataBase;
    final result = await db.query(
      'Movies',
      where: 'isFavorite = ?',
      whereArgs: [1],
    );
    return result.map((row) => row['imdbID'] as String).toList();
  }
}
