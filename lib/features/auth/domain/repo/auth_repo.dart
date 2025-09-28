import 'package:dartz/dartz.dart';
import 'package:kshk/core/errors/failure.dart';
import 'package:kshk/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepo {

  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
    String email,
    String password,
    String fullName,
  );

  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
    String email,
    String password,
  );
}