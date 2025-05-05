import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:civix_app/core/models/report_model.dart';
import 'package:civix_app/core/services/shared_prefrences_singleton.dart';
import 'package:civix_app/features/home/domain/repos/home_repo.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeRepo) : super(HomeInitial()) {
    _initialize();
  }

  final HomeRepo homeRepo;
  String? savedArea;

  Future<void> _initialize() async {
    await getSavedArea();
    await fetchNearMe();
  }

  Future<void> fetchNearMe() async {
    emit(HomeLoading());
    if (savedArea == null) return;
    var result = await homeRepo.fetchNearMe(area: savedArea);
    log(result.toString());
    result.fold(
      (failure) => emit(HomeFailure(failure.message)),
      (reports) => emit(HomeSuccess(reports)),
    );
  }

  Future<void> saveArea(String area) async {
    savedArea = area;
    try {
      await Prefs.setString('savedArea', area);
      await fetchNearMe();
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Future<void> getSavedArea() async {
    emit(HomeLoading());
    try {
      savedArea = await Prefs.getString('savedArea');
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
