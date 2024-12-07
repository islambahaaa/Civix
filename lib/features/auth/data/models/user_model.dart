import 'package:civix_app/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel(
      {required super.fname,
      required super.lname,
      required super.email,
      required super.token});
  factory UserModel.fromUserEntity(UserEntity user) {
    return UserModel(
      fname: user.fname,
      lname: user.lname,
      email: user.email,
      token: user.token,
    );
  }
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fname: json['fullName'].split(' ')[0],
      lname: json['fullName'].split(' ')[1],
      email: json['email'],
      token: json['token'],
    );
  }
}
