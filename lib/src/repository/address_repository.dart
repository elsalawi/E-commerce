import 'dart:convert';

import 'package:orders_app/src/modals/response_modal.dart';
import 'package:orders_app/src/utils/exceptions/custom_exceptions.dart';
import 'package:orders_app/src/utils/http/http_helper.dart';

class AddressRepository {
  Future<ResponseModel> fetchPickupAddress() async {
    try {
      final res = await HttpHelper.getPickupAddress()
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
  Future<ResponseModel> fetchDropOffCities() async {
    try {
      final res = await HttpHelper.getDropOffCities()
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
