import 'dart:developer';

import 'package:bloc/bloc.dart';

import 'package:civix_app/core/models/report_model.dart';
import 'package:civix_app/features/my_reports/domain/repos/my_reports_repo.dart';
import 'package:meta/meta.dart';

part 'my_reports_state.dart';

class MyReportsCubit extends Cubit<MyReportsState> {
  MyReportsCubit(this.myReportsRepo) : super(MyReportsInitial());
  final MyReportsRepo myReportsRepo;
  Future<void> fetchMyReports() async {
    emit(MyReportsLoading());
    var result = await myReportsRepo.fetchMyReports();
    log(result.toString());
    result.fold(
      (failure) => emit(MyReportsFailure(failure.message)),
      (reports) => emit(MyReportsSuccess(reports)),
    );
  }
}
