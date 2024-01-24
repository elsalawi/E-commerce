import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:orders_app/src/modals/order_model.dart';
import 'package:orders_app/src/modals/response_modal.dart';
import 'package:orders_app/src/utils/exceptions/custom_exceptions.dart';
import 'package:orders_app/src/utils/http/http_helper.dart';
import 'package:orders_app/src/utils/storage/storage_helper.dart';
import 'package:orders_app/src/utils/storage/storage_keys.dart';

class OrdersRepository {

  Future<ResponseModel> getOrders(
      {bool isCustomerOrders = false,
      int customerId = -1,
      bool? isArchive}) async {
    try {
      String? userId = await StorageHelper.get(StorageKeys.userId);
      print("getOrders");
      print(userId);
      final res = await HttpHelper.getOrders(userId!,
          customerId: customerId,
          isCustomerOrder: isCustomerOrders,
          isArchive: isArchive ?? false)
          .timeout(const Duration(minutes: 1));
      final data = jsonDecode(res.data);
      final response = ResponseModel.fromJson(data);
      if (!response.success) {
        response.message = CustomException.codeMessage(response.status);
      }
      return response;
    } catch (e) {
      return CustomException.errorMessage(e);
    }
  }

  Future<ResponseModel> getDefaults() async {
    try {
      final res = await HttpHelper.getDefaults()
          .timeout(const Duration(minutes: 1));
      final data = jsonDecode(res.data);
      final response = ResponseModel.fromJson(data);
      if (!response.success) {
        response.message = CustomException.codeMessage(response.status);
      }
      return response;
    } catch (e) {
      return CustomException.errorMessage(e);
    }
  }

  Future<ResponseModel> create(OrderModel order) async {
    try {
      var userId = await StorageHelper.get(StorageKeys.userId);
      var partnerId = await StorageHelper.get(StorageKeys.partnerId);
      final res = await HttpHelper.createOrder(userId!, partnerId!, order)
          .timeout(const Duration(minutes: 1));
      final data = jsonDecode(res.data);
      final response = ResponseModel.fromJson(data);
      if (!response.success) {
        response.message = CustomException.codeMessage(response.status);
      }
      return response;
    } catch (e) {
      return CustomException.errorMessage(e);
    }
  }

  Future<ResponseModel> update(OrderModel order) async {
    try {
      var userId = await StorageHelper.get(StorageKeys.userId);
      var partnerId = await StorageHelper.get(StorageKeys.partnerId);
      final res = await HttpHelper.updateOrder(userId!, partnerId!, order)
          .timeout(const Duration(minutes: 1));
      final data = jsonDecode(res.data);
      final response = ResponseModel.fromJson(data);
      if (!response.success) {
        response.message = CustomException.codeMessage(response.status);
      }
      return response;
    } catch (e) {
      return CustomException.errorMessage(e);
    }
  }

  Future<ResponseModel> loadMore(String nextPage) async {
    try {
      final userId = await StorageHelper.get(StorageKeys.userId);

      final res = await HttpHelper.getLink(nextPage, userId!)
          .timeout(const Duration(minutes: 1));
      final data = jsonDecode(res.data);
      final response = ResponseModel.fromJson(data);
      if (!response.success) {
        response.message = CustomException.codeMessage(response.status);
      }
      return response;
    } catch (e) {
      return CustomException.errorMessage(e);
    }
  }
}
