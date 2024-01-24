
bool isParsable(dynamic data) => data != null && data.runtimeType != bool;

typedef ModelBuilder<T> = List<T> Function(dynamic data);
typedef PaginationResponse<T> = Future<PaginationResponseModel<T>> Function(
    String url, Map<String, dynamic> data);

class PaginationResponseModel<T> {
  final bool success;
  final int status;
  String message;
  dynamic data;

  PaginationResponseModel({
    required this.status,
    required this.message,
    required this.success,
    this.data,
  });
  PaginationResponseModel.error({required this.message, this.data})
      : status = 400,
        success = false;
  PaginationResponseModel.errorStatus({
    required this.message,
    this.data,
    required this.status,
  }) : success = false;

  PaginationResponseModel.connectionError({required this.message, this.data})
      : status = 7001,
        success = false;

  PaginationResponseModel.fromJson(Map<String, dynamic> json)
      : success = parseStatus(json["success"]),
        status = 200,
        message = json["message"],
        data = isParsable(json["data"]) ? json['data'] : null;

  static bool parseStatus(dynamic value) {
    if (value.runtimeType == bool) return value;
    if (value.runtimeType == String) return value == "true" ? true : false;
    return false;
  }

  bool get isValid => success == true && data != null;

  @override
  String toString() {
    return "$success , $status, $message $data";
  }

  bool get isSuccess => success == true && status == 200;

  bool get isConnectionError => status == 7001;


}