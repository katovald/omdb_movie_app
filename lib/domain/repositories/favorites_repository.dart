abstract class FavoritesRepository {
  Future<void> addFavorite(String movieId);
  Future<void> removeFavorite(String movieId);
  Future<bool> isFavorite(String movieId);
}