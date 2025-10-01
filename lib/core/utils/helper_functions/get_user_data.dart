import 'dart:convert';
import 'package:kshk/core/Services/shared_prefrences_singletone.dart';
import 'package:kshk/core/utils/constants.dart';
import 'package:kshk/features/auth/data/models/user_model.dart';
import 'package:kshk/features/auth/domain/entities/user_entity.dart';

UserEntity getUserData() {
  var json = SharedPreferencesSingleton.getString(kUserData);
  var userModel = UserModel.fromJson(jsonDecode(json));
  return userModel.toEntity(userModel);
}
