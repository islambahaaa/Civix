part of 'report_cubit.dart';

@immutable
sealed class ReportState {}

final class ReportInitial extends ReportState {}

class ReportLoading extends ReportState {}

class ReportImagesSuccess extends ReportState {
  final List<XFile> images;

  ReportImagesSuccess(this.images);
}

class ReportFailure extends ReportState {
  final String message;
  ReportFailure(this.message);
}

class ReportLocationSuccess extends ReportState {
  final Position position;
  ReportLocationSuccess(this.position);
}

class ReportSuccess extends ReportState {}
