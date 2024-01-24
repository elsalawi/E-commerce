import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:orders_app/src/modals/response_modal.dart';

import '../../../generated/l10n.dart' show S;


class CustomException implements Exception {
  final String data;

  CustomException(this.data);

  String toString() => data;

  static ResponseModel errorMessage(dynamic e) {
    if (e is TimeoutException) {
      final message = S.current.timeout_error;
      final data = null;
      return ResponseModel.error(message: message, data: data);
    }

    if (e is DioError) {
      /// Http error
      final response = e.response;
      if (response != null) {
        final status = response.statusCode;
        final data = response.data;
        if (status == 400 && data != null && data is Map<String, dynamic>) {
          final message = data["message"] ?? S.current.unknown;
          return ResponseModel.error(message: message, data: data);
        }
        if (status != null) {
          return ResponseModel.errorStatus(
              status: status, message: "Unknown error", data: data);
        }
      }

      /// Connection error
      if (e.type == DioErrorType.connectTimeout && e.error is SocketException) {
        final osError = (e.error as SocketException).osError;
        if (osError != null && osError.errorCode == 111) {
          final message = S.current.unknown_exception(osError.message);
          return ResponseModel.connectionError(message: message, data: null);
        } else {
          final message = S.current.contact_admin;
          return ResponseModel.connectionError(message: message, data: null);
        }
      }

      /// Socket
      if (e.error is SocketException) {
        final message = S.current.socket_error;
        return ResponseModel.connectionError(message: message, data: null);
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
      ResponseModel.errorStatus(message: message, status: status, data: null);
    } else {
      final message = e.toString();
      ResponseModel.error(message: message, data: null);
    }
    return ResponseModel.error(message: S.current.unhandled_error, data: null);
  }

  static String codeMessage(int code) {
    var message;
    switch (code) {
      case 1000:
        message = S.current.error_1000;
        break;
      case 1101:
        message = S.current.error_1101;
        break;
      case 1102:
        message = S.current.error_1102;
        break;
      case 1103:
        message = S.current.error_1103;
        break;
      case 1104:
        message = S.current.error_1104;
        break;
      case 1105:
        message = S.current.error_1105;
        break;
      case 1106:
        message = S.current.error_1106;
        break;
      case 1107:
        message = S.current.error_1107;
        break;
      case 1108:
        message = S.current.error_1108;
        break;
      case 1109:
        message = S.current.error_1109;
        break;
      case 1110:
        message = S.current.error_1110;
        break;
      case 1111:
        message = S.current.error_1111;
        break;
      case 1112:
        message = S.current.error_1112;
        break;
      case 1113:
        message = S.current.error_1113;
        break;
      case 1114:
        message = S.current.error_1113;
        break;
      case 1115:
        message = S.current.error_1113;
        break;
      default:
        message = S.current.error_1116;
    }
    return message;
  }

  static String expToString(error) {
    switch (error.runtimeType) {
      case TimeoutException:
        return S.current.timeout;
      default:
        return error.toString();
    }
  }
  static String formatException(error) {
    if (error == null) return S.current.unknown;

    final message = error.toString();
    if (error is Exception) {
      return message.startsWith("Exception: ")
          ? message.substring("Exception: ".length)
          : error.toString();
    }
    return message;
  }

}

String simplifyText(String text, length) {
  if (text.length <= length) return text;

  var cut = text.substring(0, length);
  return "$cut ...";
}
