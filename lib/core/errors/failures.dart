import 'dart:math';

import 'package:civix_app/generated/l10n.dart';
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
        return ServerFailure(S.current.connection_timeout);
      case DioExceptionType.sendTimeout:
        return ServerFailure(S.current.send_timeout);
      case DioExceptionType.receiveTimeout:
        return ServerFailure(S.current.receive_timeout);
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            dioerror.response!.statusCode!, dioerror.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure(S.current.connection_cancelled);
      case DioExceptionType.connectionError:
        return ServerFailure(S.current.no_internet);
      case DioExceptionType.unknown:
        if (dioerror.message != null &&
            dioerror.message!.contains('SocketException')) {
          return ServerFailure(S.current.no_internet);
        }
        return ServerFailure(S.current.unexpected_error);
      default:
        return ServerFailure(S.current.something_wrong);
    }
  }
  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      if (response is String) {
        return ServerFailure(response);
      } else if (response is Map<String, dynamic> &&
          response.containsKey('errors')) {
        var errors = response['errors'];

        if (errors is Map<String, dynamic>) {
          // Extract the first available error message dynamically
          for (var key in errors.keys) {
            if (errors[key] is List) {
              return ServerFailure((errors[key] as List).join(', '));
            }
          }
        } else if (errors is List &&
            errors.isNotEmpty &&
            errors[0] is Map<String, dynamic>) {
          // Handle list of errors, get the 'description' field if present
          var listedErrors = errors[0];
          if (listedErrors.containsKey('description')) {
            return ServerFailure(listedErrors['description']);
          }
        }

        return ServerFailure(errors.toString());
      }

      return ServerFailure(response.toString());
    } else if (statusCode == 404) {
      return ServerFailure(S.current.not_found);
    } else if (statusCode == 500) {
      return ServerFailure(S.current.server_error);
    } else {
      return ServerFailure(S.current.something_wrong);
    }
  }
}
