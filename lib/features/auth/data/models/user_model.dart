import 'package:firebase_auth/firebase_auth.dart';
import 'package:kshk/features/auth/domain/entities/user_entity.dart';

class UserModel {
  final String userId;
  final String email;
  final String fullName;

  UserModel({
    required this.userId,
    required this.email,
    required this.fullName,
  });

  factory UserModel.fromFirebase(User user) {
    return UserModel(
      userId: user.uid,
      email: user.email!,
      fullName: user.displayName ?? '',
    );
  }

  factory UserModel.fromEntity(UserEntity user) {
    return UserModel(
      userId: user.uid,
      email: user.email,
      fullName: user.fullName,
    );
  }
  Map<String, dynamic> toMap() {
    return {'userId': userId, 'email': email, 'fullName': fullName};
  }

  UserEntity toEntity(UserModel model) {
    return UserEntity(
      uid: model.userId,
      email: model.email,
      fullName: model.fullName,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      email: json['email'],
      fullName: json['fullName'],
    );
  }
}
