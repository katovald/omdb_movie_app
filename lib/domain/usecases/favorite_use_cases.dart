import 'package:omdb_movie_app/data/repositories/favorites_repository_imp.dart';

class SaveFavoriteUseCase {
  final FavoritesRepositoryImp repository;

  SaveFavoriteUseCase(this.repository);

  Future<void> call(String movieId) async {
    return repository.addFavorite(movieId);
  }
}

class RemoveFavoriteUseCase {
  final FavoritesRepositoryImp repository;

  RemoveFavoriteUseCase(this.repository);

  Future<void> call(String movieId) async {
    return repository.removeFavorite(movieId);
  }
}

class IsFavoriteUseCase {
  final FavoritesRepositoryImp repository;

  IsFavoriteUseCase(this.repository);

  Future<bool> call(String movieId) async {
    return repository.isFavorite(movieId);
  }
}