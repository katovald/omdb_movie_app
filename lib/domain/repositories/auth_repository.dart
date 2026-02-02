import 'package:dartz/dartz.dart';
import 'package:omdb_movie_app/domain/entities/user.dart';

import '../../core/error/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(String username, String password);
}