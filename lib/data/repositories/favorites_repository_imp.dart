import 'package:omdb_movie_app/data/datasources/favorites_local_data_source.dart';

class FavoritesRepositoryImp {
  // Implementation of the FavoritesRepository
  final FavoritesLocalDataSource local;

  FavoritesRepositoryImp({required this.local});

  Future<void> addFavorite(String movieId) async {
    await local.addFavorite(movieId);
  }

  Future<void> removeFavorite(String movieId) async {
    await local.removeFavorite(movieId);
  }

  Future<bool> isFavorite(String movieId) async {
    return await local.isFavorite(movieId);
  }

}