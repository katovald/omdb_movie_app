import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/favorites_bloc.dart';
import '../bloc/favorites_event.dart';
import '../bloc/favorites_state.dart';
import '../bloc/movie_bloc.dart';
import '../bloc/movie_event.dart';
import '../bloc/movie_state.dart';

/// Page displaying detailed information about a selected movie.
class DetailsPage extends StatelessWidget {
  final String movieId;
  final String posterUrl;
  final bool isFavorite;

  const DetailsPage({required this.movieId, required this.posterUrl, required this.isFavorite});

  @override
  Widget build(BuildContext context) {
    // Fetch movie details when the page is built.
    context.read<MovieBloc>().add(GetMovieDetailsEvent(movieId));
    context.read<FavoritesBloc>().add(LoadFavoritesStatus(movieId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Details'),
      ),
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MovieDetailsLoaded) {
            final details = state.movieDetails;
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            details.title,
                            style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        BlocBuilder<FavoritesBloc, FavoritesState>(
                          builder: (context, state) {
                            return IconButton(
                              onPressed: state.isLoading
                                  ? null
                                  : () {
                                      context
                                          .read<FavoritesBloc>()
                                          .add(ToggleFavorite(movieId));
                                    },
                              icon: Icon(
                                state.isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: state.isFavorite
                                    ? Colors.red
                                    : Colors.white70,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Image.network(posterUrl, fit: BoxFit.cover),
                    const SizedBox(height: 10),
                    _buildDetailRow('Year', details.year),
                    _buildDetailRow('Director', details.director),
                    _buildDetailRow('Actors', details.actors),
                    _buildDetailRow('Runtime', details.runtime),
                    _buildDetailRow('Genre', details.genre),
                    const Text(
                      'Plot',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    Text(details.plot,
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white)),
                  ],
                ),
              ),
            );
          } else if (state is MovieError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message,
                      style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<MovieBloc>()
                          .add(GetMovieDetailsEvent(movieId));
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('Unexpected error occurred.'));
          }
        },
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white70),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}
