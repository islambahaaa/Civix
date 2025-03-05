import 'package:civix_app/core/repos/report_repo.dart';
import 'package:civix_app/core/repos/report_repo_impl.dart';
import 'package:civix_app/core/services/api_auth_service.dart';
import 'package:civix_app/core/services/api_report_service.dart';
import 'package:civix_app/core/services/database_service.dart';
import 'package:civix_app/core/services/dio_client.dart';
import 'package:civix_app/features/auth/data/repos/auth_repo_impl.dart';
import 'package:civix_app/features/auth/domain/repos/auth_repo.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerSingleton(DioClient(getIt.get<Dio>()));
  getIt.registerSingleton<ApiAuthService>(
      ApiAuthService(getIt.get<DioClient>()));
  getIt.registerSingleton<ApiReportService>(
      ApiReportService(getIt.get<DioClient>()));
  getIt.registerSingleton<AuthRepo>(
      AuthRepoImpl(apiAuthService: getIt.get<ApiAuthService>()));
  getIt.registerSingleton<ReportRepo>(
      ReportRepoImpl(apiReportService: getIt.get<ApiReportService>()));
}
