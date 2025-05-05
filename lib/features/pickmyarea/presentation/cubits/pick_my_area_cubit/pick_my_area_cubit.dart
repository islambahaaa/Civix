import 'package:civix_app/features/pickmyarea/domain/repos/pick_my_area_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'pick_my_area_state.dart';

class PickMyAreaCubit extends Cubit<PickMyAreaState> {
  PickMyAreaCubit(this.pickMyAreaRepo) : super(PickMyAreaInitial());
  final PickMyAreaRepo pickMyAreaRepo;
  Future<void> fetchAreas() async {
    emit(PickMyAreaLoading());
    try {
      var result = await pickMyAreaRepo.fetchAreas();
      result.fold(
        (failure) => emit(PickMyAreaFailure(failure.message)),
        (areas) => emit(PickMyAreaSuccess(areas)),
      );
    } catch (e) {
      emit(PickMyAreaFailure(e.toString()));
    }
  }
}
