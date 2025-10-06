import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Future<Either<Failure, UserEntity>> signInWithGoogle();
  Future<Either<Failure, UserEntity>> signinWithFacebook();
  void deleteUser(User? user);

  Future<void> addUserToDatabase(UserEntity user);
  Future<UserEntity?> getCurrentUser({required String userId});
  Future saveUserData({required UserEntity user});
}
