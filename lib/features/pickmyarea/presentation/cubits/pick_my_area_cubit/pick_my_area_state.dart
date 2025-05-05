abstract class PickMyAreaState {}

class PickMyAreaInitial extends PickMyAreaState {}

class PickMyAreaLoading extends PickMyAreaState {}

class PickMyAreaSuccess extends PickMyAreaState {
  final List<String> areas;
  PickMyAreaSuccess(this.areas);
}

class PickMyAreaFailure extends PickMyAreaState {
  final String error;
  PickMyAreaFailure(this.error);
}
