import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:omdb_movie_app/data/repositories/auth_repository_imp.dart';
import 'package:omdb_movie_app/domain/usecases/login_use_case.dart';
import 'package:omdb_movie_app/presentation/bloc/favorites_bloc.dart';
import 'package:omdb_movie_app/presentation/bloc/login_bloc.dart';
import 'package:omdb_movie_app/presentation/pages/login_page.dart';

import 'data/datasources/favorites_local_data_source.dart';
import 'data/datasources/movie_remote_data_source.dart';
import 'data/repositories/favorites_repository_imp.dart';
import 'data/repositories/movie_repository_impl.dart';
import 'domain/usecases/favorite_use_cases.dart';
import 'domain/usecases/get_movie_details.dart';
import 'domain/usecases/search_movies.dart';
import 'presentation/bloc/movie_bloc.dart';

// Entry point of the Flutter application.
void main() {
  // Calls the root widget of the application.
  runApp(MyApp());
}

// The root widget of the application.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Dependency Injection:
    // - Initialize an HTTP client to handle API requests.
    final http.Client client = http.Client();

    // - Create an instance of the remote data source, which interacts with the OMDb API.
    final movieRemoteDataSource = MovieRemoteDataSourceImpl(client: client);
    final local = FavoritesLocalDataSourceImpl();

    // - Create an instance of the repository, which abstracts data operations
    //   and provides a single source of truth for the app.
    final movieRepository =
        MovieRepositoryImpl(remoteDataSource: movieRemoteDataSource, favoritesLocalDataSource: local);
    final authRepository = AuthRepositoryImp();
    final favoritesRepository = FavoritesRepositoryImp(local: local);

    // - Initialize use cases for searching movies and fetching movie details.
    final searchMovies = SearchMovies(movieRepository);
    final getMovieDetails = GetMovieDetails(movieRepository);
    final loginUseCase = LoginUseCase(authRepository);
    final saveFavoriteUseCase = SaveFavoriteUseCase(favoritesRepository);
    final removeFavoriteUseCase = RemoveFavoriteUseCase(favoritesRepository);
    final isFavoriteUseCase = IsFavoriteUseCase(favoritesRepository);

    // The `BlocProvider` is used to make the `MovieBloc` available to the widget tree.
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          // Create the `MovieBloc` and inject the required use cases for state management.
          create: (_) => MovieBloc(
            searchMovies: searchMovies,
            getMovieDetails: getMovieDetails,
          ),
        ),
        BlocProvider(
          create: (_) => LoginBloc(loginUseCase),
        ),
        BlocProvider(create: (_) => FavoritesBloc(saveFavoriteUseCase: saveFavoriteUseCase, removeFavoriteUseCase: removeFavoriteUseCase, isFavoriteUseCase: isFavoriteUseCase))
      ], // Define the app's structure and configuration.
      child: MaterialApp(
        // Remove the debug banner from the app.
        debugShowCheckedModeBanner: false,

        // Set the title of the application.
        title: 'OMDb Movie Search',

        // Apply a global theme to the app.
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),

        // Set the initial screen of the app to the `SearchPage`.
        home: LoginPage(),
      ),
    );
  }
}
