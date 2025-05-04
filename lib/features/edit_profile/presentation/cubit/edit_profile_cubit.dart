import 'package:flutter_bloc/flutter_bloc.dart';
import 'edit_profile_state.dart';

class Edit_profileCubit extends Cubit<Edit_profileState> {
  Edit_profileCubit() : super(Edit_profileInitial());

  Future<void> doSomething() async {
    emit(Edit_profileLoading());
    try {
      // Call usecase
      // emit(Edit_profileSuccess(result));
    } catch (e) {
      emit(Edit_profileFailure(e.toString()));
    }
  }
}
