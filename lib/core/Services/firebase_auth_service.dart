

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:kshk/generated/l10n.dart';

class FirebaseAuthService {


  void deleteUser() async {
    await FirebaseAuth.instance.currentUser?.delete();
  }
  Future<User> createUserWithEmailAndPassword(
      String email, String password) async {
    
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
          return credential.user!;
    } on FirebaseAuthException catch (e) {
      log(
        "Exception in firebase authService in createUserWithEmailAndPassword: ${e.toString()} and ${e.code}",
      );
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
        throw Exception(S.current.weak_password);
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
        throw Exception(S.current.email_already_in_use);
      }
    } catch (e) {
      log(
        "Exception in firebase authService in createUserWithEmailAndPassword: ${e.toString()}",
      );
      throw Exception(S.current.network_request_failed);
    }
    throw Exception(S.current.network_request_failed);
  }

}