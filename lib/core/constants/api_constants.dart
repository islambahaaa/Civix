import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static String? baseUrl = dotenv.env['API_BASE_URL'];
  static String? aiBaseUrl = dotenv.env['AI_URL'];
  static const String authEndpoint = '/api/Auth/';
  static const String myIssuesEndpoint = '/me/issues';
  static const String register = 'register';
  static const String login = 'login';
  static const String sendOtp = 'password-reset';
  static const String checkOtp = 'check-otp';
  static const String newPassword = 'reset-password';
  static const String createIssueEndPoint = '/api/issues/';
  static const String citiesNames = '/api/auth/cities-names';
  static const String solvedInMyArea = '/api/issues/solved-me';
  static const String meEndPoint = '/me';
  static const String areaByLatLong = '/api/issues/area';
  static const String editProfile = '/api/users/me';
}
