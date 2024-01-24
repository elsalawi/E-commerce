import 'dart:convert';

import 'package:orders_app/src/modals/response_modal.dart';
import 'package:orders_app/src/utils/exceptions/custom_exceptions.dart';
import 'package:orders_app/src/utils/http/http_helper.dart';

class CustomersRepository {
  Future<ResponseModel> fetch() async {
    try {
      final res = await HttpHelper.getCustomers()
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
