abstract class FavoritesEvent {}

class LoadFavoritesStatus extends FavoritesEvent {
  final String movieId;

  LoadFavoritesStatus(this.movieId);
}

class ToggleFavorite extends FavoritesEvent {
  final String movieId;

  ToggleFavorite(this.movieId);
}