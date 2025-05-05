import 'package:civix_app/core/repos/report_repo.dart';
import 'package:civix_app/core/repos/report_repo_impl.dart';
import 'package:civix_app/core/services/api_auth_service.dart';
import 'package:civix_app/core/services/api_report_service.dart';
import 'package:civix_app/core/services/api_solved_in_my_area_service.dart';
import 'package:civix_app/core/services/dio_client.dart';
import 'package:civix_app/features/auth/data/repos/auth_repo_impl.dart';
import 'package:civix_app/features/auth/domain/repos/auth_repo.dart';
import 'package:civix_app/features/edit_profile/data/repositories/edit_profile_repo_impl.dart';
import 'package:civix_app/features/edit_profile/domain/repositories/edit_profile_repo.dart';
import 'package:civix_app/features/home/data/repos/home_repo_impl.dart';
import 'package:civix_app/features/home/domain/repos/home_repo.dart';
import 'package:civix_app/features/my_reports/data/repos/my_reports_repo_impl.dart';
import 'package:civix_app/features/my_reports/domain/repos/my_reports_repo.dart';
import 'package:civix_app/core/services/firebase_notification_service.dart';
import 'package:civix_app/features/pickmyarea/data/repos/pick_my_area_repo_impl.dart';
import 'package:civix_app/features/pickmyarea/domain/repos/pick_my_area_repo.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  // dio
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerSingleton(DioClient(getIt.get<Dio>()));
  // services
  getIt.registerSingleton<ApiAuthService>(
      ApiAuthService(getIt.get<DioClient>()));
  getIt.registerSingleton<ApiSolvedInMyAreaService>(
      ApiSolvedInMyAreaService(getIt.get<DioClient>()));
  getIt.registerSingleton<ApiReportService>(
      ApiReportService(getIt.get<DioClient>()));
  getIt.registerSingleton<FirebaseNotificationService>(
      FirebaseNotificationService());
  //repos
  getIt.registerSingleton<PickMyAreaRepo>(PickMyAreaRepoImpl(
      apiSolvedInMyAreaService: getIt.get<ApiSolvedInMyAreaService>()));
  getIt.registerSingleton<AuthRepo>(
      AuthRepoImpl(apiAuthService: getIt.get<ApiAuthService>()));
  getIt.registerSingleton<HomeRepo>(HomeRepoImpl(
      apiSolvedInMyAreaService: getIt.get<ApiSolvedInMyAreaService>()));
  getIt.registerSingleton<MyReportsRepo>(
      MyReportsRepoImpl(apiReportService: getIt.get<ApiReportService>()));
  getIt.registerSingleton<ReportRepo>(
      ReportRepoImpl(apiReportService: getIt.get<ApiReportService>()));
  getIt.registerSingleton<EditProfileRepo>(
      EditProfileRepoImpl(getIt.get<ApiAuthService>()));
}
