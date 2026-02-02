import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omdb_movie_app/domain/usecases/login_use_case.dart';
import 'package:omdb_movie_app/presentation/bloc/login_event.dart';
import 'package:omdb_movie_app/presentation/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState>{
  final LoginUseCase loginUseCase;

  LoginBloc(this.loginUseCase) : super(LoginInitial()) {
    on<LoginRequest>((event, emit) async {
      emit(LoginLoading());
      // Simulate a login process
      final user = await loginUseCase(LoginParams(username: event.username, password: event.password));
      user.fold(
        (failure) => emit(LoginFailure('Login failed')),
        (user) => emit(LoginSuccess(user)),
      );
    });
  }
}