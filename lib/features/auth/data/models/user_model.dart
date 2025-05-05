import 'package:civix_app/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel(
      {required super.fname,
      required super.lname,
      required super.phoneNumber,
      required super.email,
      required super.token});
  factory UserModel.fromUserEntity(UserEntity user) {
    return UserModel(
      fname: user.fname,
      lname: user.lname,
      phoneNumber: user.phoneNumber,
      email: user.email,
      token: user.token,
    );
  }
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fname: json['fullName'].split(' ')[0],
      lname: json['fullName'].split(' ')[1],
      phoneNumber: json['phoneNumber'] ?? '',
      email: json['email'],
      token: json['token'],
    );
  }
  factory UserModel.fromMe(Map<String, dynamic> json) {
    return UserModel(
      fname: json['firstName'],
      lname: json['lastName'],
      phoneNumber: json['phoneNumber'] ?? '',
      email: json['email'],
      token: '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'fullName': '$fname $lname',
      'phoneNumber': phoneNumber,
      'email': email,
      'token': token,
    };
  }
}
