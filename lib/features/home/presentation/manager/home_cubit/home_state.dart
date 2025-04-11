part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  //final List<ReportModel> reports;

  //HomeSuccess(this.reports);
}

final class HomeFailure extends HomeState {
  final String message;

  HomeFailure(this.message);
}
