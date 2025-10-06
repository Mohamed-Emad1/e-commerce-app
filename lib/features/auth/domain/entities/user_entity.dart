import 'package:firebase_auth/firebase_auth.dart';

class UserEntity {
  final String uid;
  final String email;
  final String fullName;

  UserEntity({required this.uid, required this.email, required this.fullName});

  factory UserEntity.fromFirebaseUser(User user, {String? fullName}) {
    return UserEntity(
      uid: user.uid,
      email: user.email ?? '',
      fullName: fullName ?? user.displayName ?? '',
    );
  }
}
