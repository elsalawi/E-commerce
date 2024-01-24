import 'dart:io';

import 'package:dio/dio.dart';
import 'package:orders_app/src/modals/order_model.dart';

import '../../values/constants.dart' as BASE_URL;
import '../storage/storage_helper.dart';
import '../storage/storage_keys.dart';

class HttpHelper {
  static Dio? _client;

  static Future<Dio> _getInstance(
      {bool isAuth = false, bool? withToken}) async {
    _client ??= Dio();
    if (isAuth == true) {
      _client!.options.headers = {
        "Content-Type": "application/x-www-form-urlencoded"
      };
      return _client!;
    }
    final storageToken = await StorageHelper.get(StorageKeys.token);
    var headers = {
      'Authorization': 'Bearer $storageToken',
      "Content-Type": "application/x-www-form-urlencoded"
    };

    if (withToken != null && withToken == true) {
      headers = {
        ...headers,
        'Bearer': '$storageToken',
      };
    }
    _client!.options.headers = headers;
    return _client!;
  }

  static Future<Response> authSSO(String phone, String password) async {
    final String url = "${BASE_URL.restApi}api/v2/authorize";

    final instance = await _getInstance(isAuth: true);
    FormData payload = FormData.fromMap({
      "phone": phone,
      "password": password,
    });
    return instance.post(url, data: payload);
  }

  static Future<Response> profile(String name, String mobile) async {
    final String url = "${BASE_URL.restApi}rest_api/users";

    final instance = await _getInstance(isAuth: false, withToken: true);
    FormData payload = FormData.fromMap({
      "name": name,
      "mobile": mobile,
    });

    return instance.put(url, data: payload);
  }

  static Future<Response> checkForUpdates(String localVersion) async {
    final String url =
        "${BASE_URL.restApi}rest_api/delivery/get_customer_app_v?customer_app_v=$localVersion&application=customer";
    print("check update url is $url");
    // final instance = await _getInstance(isAuth: false, withToken: true);
    // final instance = await _getInstance(isAuth: true);
    final instance = await _getInstance(isAuth: true);
    FormData payload = FormData.fromMap({
      "customer_app_v": localVersion,
      "application": "customer",
    });

    return instance.get(url);
    // return instance.get(url, data: payload);
  }

  static Future<Response> changeAvatar(File image) async {
    final String url = "${BASE_URL.restApi}rest_api/users/avatar";

    final instance = await _getInstance(isAuth: false, withToken: true);

    print("name is .... *** ${image}");

    FormData payload = FormData.fromMap({
      "image": await MultipartFile.fromFile(
        image.path,
//        filename: image.path.split('/').last,
      ),
    });
    return instance.put(url, data: payload);

//    payload.add("image",  UploadFileInfo(image, image.path));
//
//    return instance.post(url, data: payload);
  }

  static Future<Response> info(int userId) async {
    final String url = "${BASE_URL.restApi}/users/$userId";

    final instance = await _getInstance(isAuth: true);

    return instance.get(url);
  }

  static Future<Response> changePassword(
      String oldPassword, String newPassword) async {
    final String url = "${BASE_URL.restApi}rest_api/users/password";
    final instance = await _getInstance(isAuth: false, withToken: true);

    FormData payload = FormData.fromMap({
      "old_password": oldPassword,
      "new_password": newPassword,
    });
    return instance.put(url, data: payload);
  }

  static Future<Response> getOrders(String userId,
      {bool isCustomerOrder = false,
      int? customerId,
      bool isArchive = false}) async {
    print("http helper");
    print(isArchive);
    final String url =
        "${BASE_URL.restApi}rest_api/delivery/get_orders?user_id=$userId${isCustomerOrder ? '&customer_id=$customerId' : '&is_archive=$isArchive'}";

//    final String url =
//        "${BASE_URL.restApi}rest_api/delivery/get_orders?${isCustomerOrder ? 'customer_id' : 'user_id'}=$id";

    print("final url is $url");
    final instance = await _getInstance(isAuth: true);
    return instance.get(url);
  }

  static Future<Response> getCustomers() async {
    final String url = "${BASE_URL.restApi}rest_api/delivery/get_customers";
//    final String url =
//        "${BASE_URL.restApi}rest_api/delivery/get_order_defaults";
    print(url);
    print(url);
    final instance = await _getInstance(isAuth: false, withToken: true);
    return instance.get(url);
  }

  static Future<Response> getPickupAddress() async {
    final String url = "${BASE_URL.restApi}rest_api/delivery/get_addresses";
    print(url);
//    final String url =
//        "${BASE_URL.restApi}rest_api/delivery/get_order_defaults";
    final instance = await _getInstance(isAuth: false, withToken: true);
    return instance.get(url);
  }

  static Future<Response> getDropOffCities() async {
    final String url = "${BASE_URL.restApi}rest_api/delivery/get_cities";
//    final String url =
//        "${BASE_URL.restApi}rest_api/delivery/get_order_defaults";
    final instance = await _getInstance(isAuth: true);
    return instance.get(url);
  }

  static Future<Response> getDefaults() async {
    final String url =
        "${BASE_URL.restApi}rest_api/delivery/get_order_defaults";
    final instance = await _getInstance(isAuth: true);
    return instance.get(url);
  }

  static Future<Response> getPageOrders(String page, String userId) async {
    final String url = "${BASE_URL.restApi}$page?user_id=$userId";
    final instance = await _getInstance(isAuth: true);
    return instance.get(url);
  }

  static Future<Response> getLink(String nextPage, String userId) async {
    final instance = await _getInstance(isAuth: true);
    final url = "${BASE_URL.serverUrl}$nextPage";
//    FormData payload =  FormData.fromMap({"user_id": userId});
//    FormData payload =  FormData.fromMap({"user_id": userId});
    Map<String, dynamic> payload = {"user_id": userId};

    return instance.get(url, queryParameters: payload);
  }

  static Future<Response> createOrder(
      String userId, String partnerId, OrderModel order) async {
    print("come throw here ... 0222");
    final String url = "${BASE_URL.restApi}rest_api/delivery/create_order";
    final instance = await _getInstance(isAuth: true);
    // FormData payload =  FormData.fromMap(order.toJson());
    FormData payload = FormData.fromMap({
      //pickup
      "pickup_name": order.pickupName,
      "pickup_address": order.pickupAddress!.id,
      "pickup_mobile": order.pickUptMobile,
      //dorpoff
      "dropoff_name": order.dropOffName,
      "dropoff_address": order.dropOffAddress,
      "dropoff_city": order.dropOffCity!.id,
      "dropoff_mobile": order.dropOffMobile,
      //price
      "package_price": order.packagePrice,
      "price": order.deliveryCharge,
      "paid_amount": order.paidAmount,
      "collection_amount": order.collectionAmount,
      "collected_amount": order.collectedAmount,
      //others
      "description": order.description,
      "state": order.state,
      "user_id": userId,
      "partner_id": partnerId,
      "customer_app": true,
    });
    return instance.put(url, data: payload);
  }

  static Future<Response> updateOrder(
    String userId,
    String partnerId,
    OrderModel order,
  ) async {
    print("order id ...${order.id} ${order.updateOnlyState} ${order.state}");
    final String url =
        "${BASE_URL.restApi}rest_api/delivery/${order.updateOnlyState ? 'order_update_state' : 'update_order'}";
    print(url);
    final instance = await _getInstance(isAuth: true);
    FormData payload = FormData.fromMap(order.updateOnlyState
        ? {
            "state": order.state,
            "order_id": order.id,
          }
        : {
            "pickup_name": order.pickupName,
            "pickup_address": order.pickupAddress!.id,
            "pickup_mobile": order.pickUptMobile,
            //dorpoff
            "dropoff_name": order.dropOffName,
            "dropoff_address": order.dropOffAddress,
            "dropoff_city": order.dropOffCity!.id,
            "dropoff_mobile": order.dropOffMobile,
            //price
            "package_price": order.packagePrice,
            "price": order.deliveryCharge,
            "paid_amount": order.paidAmount,
            "collection_amount": order.collectionAmount,
            "collected_amount": order.collectedAmount,
            //others
            "state": order.state,
            "description": order.description,
            "user_id": userId,
            "partner_id": partnerId,
            "customer_app": true,
            "order_id": order.id,
          });
    return instance.put(url, data: payload);
  }


  static Future<Response> get(String url, {bool? withToken, dynamic body}) async {
    final instance = await _getInstance(withToken: withToken);
    return instance.get(url, queryParameters: body);
  }

  static Future<Response> post(String url,
      {dynamic body, bool? withToken, bool? withCookie}) async {
    final instance = await _getInstance(withToken: true);
    return instance.post(url, data: body);
  }

  static Future<Response> put(String url,
      {dynamic body, bool? withToken, bool? withCookie}) async {
    final instance = await _getInstance(withToken: withToken);
    return instance.put(url, data: body);
  }

  static Future<Response> delete(String url,
      {dynamic body, bool? withToken, bool? withCookie}) async {
    final instance = await _getInstance(withToken: withToken);
    return instance.delete(url);
  }
}
