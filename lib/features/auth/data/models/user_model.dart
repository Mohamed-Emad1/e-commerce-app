import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String ui;
  final String email;
  final String fullName;

  UserModel({required this.ui, required this.email, required this.fullName});

  factory UserModel.fromFirebase(User user) {
    return UserModel(
      ui: user.uid,
      email: user.email!,
      fullName: user.displayName ?? '',
    );
    
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      ui: user.uid,
      email: user.email!,
      fullName: user.displayName ?? '',
    );
  }
}
