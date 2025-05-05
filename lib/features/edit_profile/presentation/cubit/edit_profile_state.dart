import 'package:civix_app/features/auth/domain/entities/user_entity.dart';

abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}

class EditProfileSuccess extends EditProfileState {
  final UserEntity user;
  EditProfileSuccess(this.user);
}

class EditProfileUpdated extends EditProfileState {}

class EditProfileFailure extends EditProfileState {
  final String error;
  EditProfileFailure(this.error);
}
