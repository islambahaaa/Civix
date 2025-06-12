part of 'report_cubit.dart';

@immutable
sealed class ReportState {}

final class ReportInitial extends ReportState {}

class ReportLoading extends ReportState {}

class ReportFailure extends ReportState {
  final String message;
  ReportFailure(this.message);
}

class ReportSuccess extends ReportState {
  final String message;
  ReportSuccess(this.message);
}

class ReportPredictionSuccess extends ReportState {
  final String predictedCategory;
  ReportPredictionSuccess(this.predictedCategory);
}

class ReportPredictionFailure extends ReportState {
  final String message;
  ReportPredictionFailure(this.message);
}
