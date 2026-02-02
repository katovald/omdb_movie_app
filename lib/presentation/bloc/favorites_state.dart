class FavoritesState {
  final bool isFavorite;
  final bool isLoading;
  final String? errorMessage;

  FavoritesState({
    required this.isFavorite,
    this.isLoading = false,
    this.errorMessage,
  });

  factory FavoritesState.initial() {
    return FavoritesState(isFavorite: false);
  }

  FavoritesState copyWith({
    bool? isFavorite,
    bool? isLoading,
    String? errorMessage,
  }) {
    return FavoritesState(
      isFavorite: isFavorite ?? this.isFavorite,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}
