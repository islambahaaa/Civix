import 'package:civix_app/features/pickmyarea/domain/repos/pick_my_area_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
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

  Future<void> fetchAreasByLatLong() async {
    emit(PickMyAreaLoading());
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return;
      }
      final position = await Geolocator.getCurrentPosition();
      var result = await pickMyAreaRepo.fetchAreasBylatlong(
          position.latitude, position.longitude);
      result.fold(
        (failure) => emit(PickMyAreaFailure(failure.message)),
        (areas) => emit(PickMyAreaSuccess([areas])),
      );
    } catch (e) {
      emit(PickMyAreaFailure(e.toString()));
    }
  }
}
