import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:kshk/core/errors/failure.dart';
import 'package:kshk/generated/l10n.dart';

class FirebaseAuthService {
  void deleteUser() async {
    await FirebaseAuth.instance.currentUser?.delete();
  }

  Future<User> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log(
        "Exception in firebase authService in createUserWithEmailAndPassword: ${e.toString()} and ${e.code}",
      );
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
        throw ServerFailure(S.current.weak_password);
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
        throw ServerFailure(S.current.email_already_in_use);
      }
    } catch (e) {
      log(
        "Exception in firebase authService in createUserWithEmailAndPassword: ${e.toString()}",
      );
      throw ServerFailure(S.current.network_request_failed);
    }
    throw ServerFailure(S.current.network_request_failed);
  }

  Future<User> signinWithEmailAndPassword(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return credential.user!;
    } 
    on FirebaseAuthException catch (e) {
      log(
        "Exception in firebase authService in signinWithEmailAndPassword: ${e.toString()} and ${e.code}",
      );
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
        throw ServerFailure(S.current.user_not_found);
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
        throw ServerFailure(S.current.wrong_password);
      }
      throw ServerFailure(S.current.an_error_occurred);
    }    
    catch (e) {
      log(
        "Exception in firebase authService in signinWithEmailAndPassword: ${e.toString()}",
      );
      throw ServerFailure(S.current.network_request_failed);
    }
  }



}
