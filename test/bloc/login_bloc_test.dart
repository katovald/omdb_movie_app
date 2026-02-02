import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:omdb_movie_app/domain/usecases/login_use_case.dart';
import 'package:omdb_movie_app/presentation/bloc/login_bloc.dart';
import 'package:omdb_movie_app/presentation/bloc/login_event.dart';
import 'package:omdb_movie_app/presentation/bloc/login_state.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}

void main() {
  late LoginBloc loginBloc;
  late MockLoginUseCase mockLoginUseCase;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    loginBloc = LoginBloc(mockLoginUseCase);
  });

  blocTest<LoginBloc, LoginState>(
      'emits [Loading, Success, Error] at login events',
      build: () {
        when(() => mockLoginUseCase(LoginParams(username: '', password: '')))
            .thenThrow(Exception("Invalid parameters"));
        return loginBloc;
      },
      act: (bloc) => bloc.add(LoginRequest(username: '', password: '')),
      expect: () => [isA<LoginLoading>(), isA<LoginFailure>()]);
}
