import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kshk/core/Services/firebase_auth_service.dart';
import 'package:kshk/core/errors/failure.dart';
import 'package:kshk/features/auth/domain/entities/user_entity.dart';
import 'package:kshk/features/auth/domain/repo/auth_repo.dart';

class AuthRepoImp implements AuthRepo {
  final FirebaseAuthService firebaseAuthService;

  AuthRepoImp({required this.firebaseAuthService});
  @override
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
    String email,
    String password,
    String fullName,
  ) async {
    User? user;

    try {
      user = await firebaseAuthService.createUserWithEmailAndPassword(
        email,
        password,
      );
      final userEntity = UserEntity(
        uid: user.uid,
        email: user.email!,
        fullName: fullName,
      );

      return Right(userEntity);
    } catch (e) {
      log(
        "Exception is created in AuthRepoImp create user with email and password : ${e.toString()}",
      );
      deleteUser(user);
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    User? user;
    try {
      user = await firebaseAuthService.signinWithEmailAndPassword(
        email,
        password,
      );
      final UserEntity userEntity = UserEntity(
        uid: user.uid,
        email: user.email!,
        fullName: user.displayName ?? '',
      );
      return Right(userEntity);
    } catch (e) {
      log(
        "Exception is created in AuthRepoImp sign in with email and password : ${e.toString()}",
      );
      return Left(ServerFailure(e.toString()));
    }
  }

  void deleteUser(User? user) async {
    if (user != null) {
      firebaseAuthService.deleteUser();
    }
  }
}
