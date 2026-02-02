import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:omdb_movie_app/domain/entities/user.dart';
import 'package:omdb_movie_app/domain/repositories/auth_repository.dart';
import 'package:omdb_movie_app/domain/usecases/login_use_case.dart';

class MockAuthRepository extends Mock implements AuthRepository{}

void main() {
  late LoginUseCase useCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = LoginUseCase(mockAuthRepository);
  });

  test('should call login on the repository with correct username and password', () async {
    // arrange
    const tUsername = 'test';
    const tPassword = 'password';

    when(mockAuthRepository.login(tUsername, tPassword))
        .thenAnswer((_) async => Right(User(tUsername)));

    final result = await useCase(LoginParams(username: tUsername, password: tPassword));

    expect(result, Right(User(tUsername)));
    verify(mockAuthRepository.login(tUsername, tPassword));
    verifyNoMoreInteractions(mockAuthRepository);
  });
}