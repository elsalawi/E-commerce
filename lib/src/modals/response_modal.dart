import 'pagination_model.dart';

class ResponseModel {
  bool success;
  int status;
  String message;
  dynamic data;

  ResponseModel({
    required this.status,
    required this.message,
    required this.success,
    this.data,
  });
  ResponseModel.error({required this.message, this.data})
      : status = 400,
        success = false;
  ResponseModel.errorStatus({
    required this.message,
    this.data,
    required this.status,
  }) : success = false;

  ResponseModel.connectionError({required this.message, this.data})
      : status = 7001,
        success = false;

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    print("fromJson 1");
    final success = json["success"] == "false" ? false : true;
    final status = json["error_code"] ?? 200;
    final message = json["message"] as String;
    final data = json["data"];
    print("fromJson 2" );
    return ResponseModel(
      message: message,
      success: success,
      status: status,
      data: data,
    );
  }

  factory ResponseModel.fromMap(Map<String, dynamic> json) {
    final success = json["success"] == "false" ? false : true;
    final status = json["error_code"] ?? 200;
    final message = json["message"] as String;
    final data = PaginationModel.fromMap(json["data"]);
    return ResponseModel(
      message: message,
      success: success,
      status: status,
      data: data,
    );
  }

  bool get isValid => success == true && data != null;

  @override
  String toString() {
    return "$success , $status, $message $data";
  }

  bool get isSuccess => success == true && status == 200;
}
