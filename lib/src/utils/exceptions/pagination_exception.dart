

import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:orders_app/src/pagination/model/response_model.dart';

import '../../../generated/l10n.dart' show S;

class ErrorResponseModel<T> {

  PaginationResponseModel<T> errorMessage(dynamic e) {
    if (e is TimeoutException) {
      final message = S.current.timeout_error;
      final data = null;
      return PaginationResponseModel.error(message: message, data: data);
    }

    if (e is DioError) {
      /// Http error
      final response = e.response;
      if (response != null) {
        final status = response.statusCode;
        final data = response.data;
        if (status == 400 && data != null && data is Map<String, dynamic>) {
          final message = data["message"];
          return PaginationResponseModel<T>.error(message: message ??  S.current.unknown, data: data);
        }
        if (status != null) {
          return PaginationResponseModel<T>.errorStatus(
              status: status, message: S.current.unknown, data: data);
        }
      }

      /// Connection error
      if (e.type == DioErrorType.connectTimeout && e.error is SocketException) {
        final osError = (e.error as SocketException).osError;
        if (osError != null && osError.errorCode == 111) {
          final message = S.current.unknown_exception(osError.message);
          return PaginationResponseModel<T>.connectionError(message: message, data: null);
        } else {
          final message = S.current.contact_admin;
          return PaginationResponseModel<T>.connectionError(message: message, data: null);
        }
      }

      /// Socket
      if (e.error is SocketException) {
        final message = S.current.socket_error;
        return PaginationResponseModel<T>.connectionError(message: message, data: null);
      }

      /// Server internal errors
      var message = e.toString();
      if (response?.statusCode == 401) {
        message = S.current.error_401;
      } else if (403 == response?.statusCode) {
        message = S.current.error_403;
      } else if (404 == response?.statusCode) {
        message = S.current.error_404;
      } else if (500 == response?.statusCode) {
        message = S.current.error_500;
      } else if (503 == response?.statusCode) {
        message = S.current.error_500;
      } else if (400 == response?.statusCode) {
        if (response != null &&
            response.data != null &&
            response.data.runtimeType == Map) {
          message = (response.data as Map).containsKey("message")
              ? response.data['message']
              : S.current.socket_error;
        }
      } else if (497 == response?.statusCode) {
         message = S.current.error_479;
      }else {
        message = S.current.unknown;
      }
      int status = 400;
      if (response != null && response.statusCode != null) {
        status = response.statusCode!;
      }
      PaginationResponseModel<T>.errorStatus(message: message, status: status, data: null);
    } else {
      final message = e.toString();
      PaginationResponseModel<T>.error(message: message, data: null);
    }
    return PaginationResponseModel<T>.error(message: S.current.unhandled_error, data: null);
  }
}
