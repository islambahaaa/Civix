part of 'my_reports_cubit.dart';

@immutable
sealed class MyReportsState {}

final class MyReportsInitial extends MyReportsState {}

final class MyReportsLoading extends MyReportsState {}

final class MyReportsSuccess extends MyReportsState {
  final List<ReportModel> reports;

  MyReportsSuccess(this.reports);
}

final class MyReportsFailure extends MyReportsState {
  final String message;

  MyReportsFailure(this.message);
}
