import 'dart:io';

import 'package:orders_app/src/modals/response_modal.dart';
import 'package:orders_app/src/utils/exceptions/custom_exceptions.dart';
import 'package:orders_app/src/utils/http/http_helper.dart';

class AuthRepository {
  Future<ResponseModel> changeAvatar(File image) async {
    try {
      final res = await HttpHelper.changeAvatar(image)
          .timeout(const Duration(minutes: 1));
      final response = ResponseModel.fromJson(res.data);
      if (!response.success) {
        response.message = CustomException.codeMessage(response.status);
      }
      return response;
    } catch (e) {
      return CustomException.errorMessage(e);
    }
  }

  Future<ResponseModel> changePassword(String oldPass, String newPass) async {
    try {
      final res = await HttpHelper.changePassword(oldPass, newPass)
          .timeout(const Duration(minutes: 1));
      final response = ResponseModel.fromJson(res.data);
      if (!response.success) {
        response.message = CustomException.codeMessage(response.status);
      }
      return response;
    } catch (e) {
      return CustomException.errorMessage(e);
    }
  }

  Future<ResponseModel> login(String login, String password) async {
    try {
      final res = await HttpHelper.authSSO(login.trim(), password.trim())
          .timeout(const Duration(minutes: 1));
      final response = ResponseModel.fromJson(res.data);
      if (!response.success) {
        response.message = CustomException.codeMessage(response.status);
      }
      return response;
    } catch (e) {
      return CustomException.errorMessage(e);
    }
  }

  Future<ResponseModel> changeInfo(String name, String mobile) async {
    try {
      final res = await HttpHelper.profile(name, mobile)
          .timeout(const Duration(minutes: 1));
      final response = ResponseModel.fromJson(res.data);
      if (!response.success) {
        response.message = CustomException.codeMessage(response.status);
      }
      return response;
    } catch (e) {
      return CustomException.errorMessage(e);
    }
  }
  Future<ResponseModel> checkForUpdates(String localVersion) async {
    try {
      final res = await HttpHelper.checkForUpdates(localVersion)
          .timeout(const Duration(minutes: 1));
      final response = ResponseModel.fromJson(res.data);
      if (!response.success) {
        response.message = CustomException.codeMessage(response.status);
      }
      return response;
    } catch (e) {
      return CustomException.errorMessage(e);
    }
  }

}
