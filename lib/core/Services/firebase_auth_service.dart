import 'dart:convert';
import 'dart:developer' as logger;
import 'dart:io';
import 'dart:math';
import 'package:crypto/crypto.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
      logger.log(
        "Exception in firebase authService in createUserWithEmailAndPassword: ${e.toString()} and ${e.code}",
      );
      if (e.code == 'weak-password') {
        logger.log('The password provided is too weak.');
        throw ServerFailure(S.current.weak_password);
      } else if (e.code == 'email-already-in-use') {
        logger.log('The account already exists for that email.');
        throw ServerFailure(S.current.email_already_in_use);
      }
    } catch (e) {
      logger.log(
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
      logger.log(
        "Exception in firebase authService in signinWithEmailAndPassword: ${e.toString()} and ${e.code}",
      );
      if (e.code == 'user-not-found') {
        logger.log('No user found for that email.');
        throw ServerFailure(S.current.user_not_found);
      } else if (e.code == 'wrong-password') {
        logger.log('Wrong password provided for that user.');
        throw ServerFailure(S.current.wrong_password);
      }
      throw ServerFailure(S.current.an_error_occurred);
    }    
    catch (e) {
      logger.log(
        "Exception in firebase authService in signinWithEmailAndPassword: ${e.toString()}",
      );
      throw ServerFailure(S.current.network_request_failed);
    }
  }

  Future<User> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return (await FirebaseAuth.instance.signInWithCredential(credential)).user!;
  }


  Future<User> signInWithFacebook() async {
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login(
      nonce: nonce,
    );

    // Create a credential from the access token
     OAuthCredential facebookAuthCredential;

    logger.log("tokenType${loginResult.accessToken!.type}");

    if (Platform.isIOS) {
      switch (loginResult.accessToken!.type) {
        case AccessTokenType.classic:
          final token = loginResult.accessToken as ClassicToken;
          facebookAuthCredential = FacebookAuthProvider.credential(
            token.authenticationToken!,
          );
          break;
        case AccessTokenType.limited:
          final token = loginResult.accessToken as LimitedToken;
          facebookAuthCredential = OAuthCredential(
            providerId: 'facebook.com',
            signInMethod: 'oauth',
            idToken: token.tokenString,
            rawNonce: rawNonce,
          );
          break;
      }
    } else {
      facebookAuthCredential = FacebookAuthProvider.credential(
        loginResult.accessToken!.tokenString,
      );
    }

    // Once signed in, return the UserCredential
    return (await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential)).user!;
  }

  bool isLoggedIn() {
    final user = FirebaseAuth.instance.currentUser;
    return user != null;
  }


  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(
      length,
      (_) => charset[random.nextInt(charset.length)],
    ).join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

}
