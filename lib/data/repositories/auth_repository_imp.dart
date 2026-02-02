import 'package:dartz/dartz.dart';
import 'package:omdb_movie_app/domain/repositories/auth_repository.dart';

import '../../core/error/failures.dart';
import '../../domain/entities/user.dart';

class AuthRepositoryImp implements AuthRepository {
  @override
  Future<Either<Failure, User>> login(String username, String password) async{
    await Future.delayed(const Duration(seconds: 2));
    if (username == 'test' && password == 'password') {
      return Right(User(username));
    } else {
      return Left(ServerFailure());
    }
  }

}