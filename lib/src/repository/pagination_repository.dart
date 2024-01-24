import 'package:orders_app/src/pagination/model/response_model.dart';
import 'package:orders_app/src/utils/exceptions/custom_exceptions.dart';
import 'package:orders_app/src/utils/exceptions/pagination_exception.dart';
import 'package:orders_app/src/utils/http/http_helper.dart';
import 'package:orders_app/src/values/constants.dart';

class PaginationRepository {
  Future<PaginationResponseModel<T>> getPage<T>(
      String url, Map<String, dynamic> data) async {
    try {
      final String srvrUrl = "$serverUrl$url";
      final res = await HttpHelper.get(srvrUrl, body: data)
          .timeout(const Duration(minutes: 1));
      final response = PaginationResponseModel<T>.fromJson(res.data);
      if (!response.success) {
        response.message = CustomException.codeMessage(response.status);
      }
      return response;
    } catch (e) {
      final error = ErrorResponseModel<T>();
      return error.errorMessage(e);
    }
  }
}