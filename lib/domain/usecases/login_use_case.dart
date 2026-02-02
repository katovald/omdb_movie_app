import 'package:dartz/dartz.dart';
import 'package:omdb_movie_app/core/error/failures.dart';
import 'package:omdb_movie_app/core/usecases/usecase.dart';
import 'package:omdb_movie_app/domain/entities/user.dart';

import '../repositories/auth_repository.dart';

class LoginParams {
  final String username;
  final String password;

  LoginParams({required this.username, required this.password});
}

class LoginUseCase implements UseCase<User, LoginParams> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(LoginParams params) {
    return repository.login(params.username, params.password);
  }
}