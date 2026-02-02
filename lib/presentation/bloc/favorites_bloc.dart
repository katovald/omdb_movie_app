import 'package:bloc/bloc.dart';
import 'package:omdb_movie_app/domain/usecases/favorite_use_cases.dart';

import 'favorites_event.dart';
import 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final SaveFavoriteUseCase saveFavoriteUseCase;
  final RemoveFavoriteUseCase removeFavoriteUseCase;
  final IsFavoriteUseCase isFavoriteUseCase;

  FavoritesBloc({
    required this.saveFavoriteUseCase,
    required this.removeFavoriteUseCase,
    required this.isFavoriteUseCase,
  }) : super(FavoritesState.initial()) {
    on<LoadFavoritesStatus>((event, emit) async {
      emit(state.copyWith(isLoading: true, errorMessage: null));

      try {
        final isFavorite = await isFavoriteUseCase(event.movieId);
        emit(state.copyWith(isFavorite: isFavorite, isLoading: false, errorMessage: null));
      } catch (e) {
        emit(state.copyWith(isLoading: false, errorMessage: 'Failed to load favorite status.'));
      }
    });

    on<ToggleFavorite>((event, emit) async {
      emit(state.copyWith(isLoading: true, errorMessage: null));
      final isFavorite = await isFavoriteUseCase(event.movieId);
      if (isFavorite) {
        await removeFavoriteUseCase(event.movieId);
      } else {
        await saveFavoriteUseCase(event.movieId);
      }
      final updatedStatus = await isFavoriteUseCase(event.movieId);
      emit(state.copyWith(isFavorite: updatedStatus, isLoading: false, errorMessage: null));
    });
  }
}
