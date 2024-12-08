import 'package:dio/dio.dart';

abstract class Failure {
  final String message;
  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMessage);

  factory ServerFailure.fromDioError(DioException dioerror) {
    switch (dioerror.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection Timeout');
      case DioExceptionType.sendTimeout:
        return ServerFailure('Send Timeout');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive Timeout');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            dioerror.response!.statusCode!, dioerror.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure('Connection Cancelled');
      case DioExceptionType.connectionError:
        return ServerFailure('NO INTERNET CONNECTION');
      case DioExceptionType.unknown:
        if (dioerror.message != null &&
            dioerror.message!.contains('SocketException')) {
          return ServerFailure('NO INTERNET CONNECTION');
        }
        return ServerFailure('Unexpected Error, Please try again!');
      default:
        return ServerFailure('Something went wrong. Please try again!');
    }
  }
  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      if (response is String) {
        return ServerFailure(response);
      } else if (response is Map<String, dynamic>) {
        if (response.containsKey('errors')) {
          if (response['errors'] is Map<String, dynamic>) {
            Map<String, dynamic> errors = response['errors'];
            if (errors.containsKey('NewPassword')) {
              List<dynamic> errors = response['errors']['NewPassword'];
              String errmsg = errors.join(', ');
              return ServerFailure(errmsg);
            }
            if (errors.containsKey('Email')) {
              List<dynamic> errors = response['errors']['Email'];
              String errmsg = errors.join(', ');
              return ServerFailure(errmsg);
            }
            if (errors.containsKey('ConfirmedPassword')) {
              List<dynamic> errors = response['errors']['ConfirmedPassword'];
              String errmsg = errors.join(', ');
              return ServerFailure(errmsg);
            }
            return ServerFailure(response.toString());
          }
        }
        Map<String, dynamic> listedErrors = response['errors'][0];

        if (listedErrors.containsKey('description')) {
          return ServerFailure(listedErrors['description']);
        }
      }
      return ServerFailure(response.toString());
    } else if (statusCode == 404) {
      return ServerFailure('Your request not found. Please try again!');
    } else if (statusCode == 500) {
      return ServerFailure('Internal Server Error. Please try again!');
    } else {
      return ServerFailure('Something went wrong. Please try again!');
    }
  }
}
