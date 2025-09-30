import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kshk/core/Services/database_service.dart';
import 'package:kshk/core/Services/firebase_auth_service.dart';
import 'package:kshk/core/errors/failure.dart';
import 'package:kshk/core/utils/backend_endpoints.dart';
import 'package:kshk/features/auth/data/models/user_model.dart';
import 'package:kshk/features/auth/domain/entities/user_entity.dart';
import 'package:kshk/features/auth/domain/repo/auth_repo.dart';

class AuthRepoImp implements AuthRepo {
  final FirebaseAuthService firebaseAuthService;
  final DatabaseService databaseService;

  AuthRepoImp(this.databaseService, {required this.firebaseAuthService});
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
      final userEntity = UserEntity.fromFirebaseUser(user, fullName: fullName);
      await addUserToDatabase(userEntity);
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
      var userEntity = await getCurrentUser(userId: user.uid);
      return Right(userEntity);
    } catch (e) {
      log(
        "Exception is created in AuthRepoImp sign in with email and password : ${e.toString()}",
      );
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  void deleteUser(User? user) async {
    if (user != null) {
      firebaseAuthService.deleteUser();
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    User? user;
    try {
      user = await firebaseAuthService.signInWithGoogle();
      UserEntity userEntity = UserEntity.fromFirebaseUser(
        user,
        fullName: user.displayName,
      ); 
      bool isUserExist = await databaseService.isUserExist(
        documentId: user.uid,
        path: BackendEndpoints.isUserExist,
      );
      
      if (!isUserExist) {
       await addUserToDatabase(UserEntity.fromFirebaseUser(user));
      } 
      return Right(userEntity);
    } catch (e) {
      log(
        "Exception is created in AuthRepoImp sign in with google : ${e.toString()}",
      );
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signinWithFacebook() async {
    User? user;
    try {
      user = await firebaseAuthService.signInWithFacebook();
            UserEntity userEntity = UserEntity.fromFirebaseUser(
        user,
        fullName: user.displayName,
      );
      bool isUserExist = await databaseService.isUserExist(
        documentId: user.uid,
        path: BackendEndpoints.isUserExist,
      );

      if (!isUserExist) {
        await addUserToDatabase(UserEntity.fromFirebaseUser(user));
      } 
      return Right(userEntity);
      // return Right(userEntity);
    } catch (e) {
      log(
        "Exception is created in AuthRepoImp sign in with facebook : ${e.toString()}",
      );
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<void> addUserToDatabase(UserEntity user) async {
    return await databaseService.addData(
      path: BackendEndpoints.addUserData,
      data: UserModel.fromEntity(user).toMap(),
      documentId: user.uid,
    );
  }

  @override
  Future<UserEntity> getCurrentUser({required String userId}) async {
    var user = await databaseService.getData(
      path: BackendEndpoints.getUserData,
    );
    return UserEntity.fromFirebaseUser(user);
  }
}
