abstract class Edit_profileState {}

class Edit_profileInitial extends Edit_profileState {}

class Edit_profileLoading extends Edit_profileState {}

class Edit_profileSuccess extends Edit_profileState {
  // final result;
  // Success(this.result);
}

class Edit_profileFailure extends Edit_profileState {
  final String error;
  Edit_profileFailure(this.error);
}
