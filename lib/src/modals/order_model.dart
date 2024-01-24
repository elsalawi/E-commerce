import 'package:orders_app/src/modals/address_model.dart';
import 'package:orders_app/src/modals/city_model.dart';

class OrderModel {
  int id;
  String state;
  String? orderName;
  String? customerName;
  String? pickupName;
  AddressModel? pickupAddress;
  String? dropOffName;
  String? dropOffAddress;
  CityModel? dropOffCity;
  String? pickUptMobile;
  double? packagePrice;
  double? deliveryCharge;
  String? dropOffMobile;
  double? paidAmount;
  double? collectionAmount;
  double? collectedAmount;
  double? dropOffBalance;
  String? description;
  bool updateOnlyState = false;

  OrderModel({
    required this.id,
    required this.state,
    this.orderName,
    this.customerName,
    this.pickupName,
    this.pickupAddress,
    this.dropOffName,
    this.dropOffAddress,
    this.dropOffCity,
    this.pickUptMobile,
    this.packagePrice,
    this.deliveryCharge,
    this.dropOffMobile,
    this.paidAmount,
    this.collectionAmount,
    this.collectedAmount,
    this.dropOffBalance,
    this.description,
  });

  OrderModel.fromJson(Map<String, dynamic> json)
      : id = json['order_id'],
        state = json['state'],
        orderName = json['name'],
        customerName = json['customer_name'],
        pickupName = json['pickup_name'],
        pickupAddress = json['order_pickup_address'] == false
            ? null
            : AddressModel.fromMap(json['order_pickup_address']),
        dropOffName = json['dropoff_name'],
        pickUptMobile = json['pickup_mobile'],
        dropOffAddress = json['dropoff_address'],
        dropOffCity = CityModel.fromMap(json['dropoff_city']),
        packagePrice = json['package_price'],
        deliveryCharge = json['price'],
        dropOffMobile = parseString(json['dropoff_mobile']),
        paidAmount = json['paid_amount'],
        collectionAmount = json['collection_amount'],
        collectedAmount = json['collected_amount'],
        dropOffBalance = json['balance'],
        description = parseString(json['description']);

  bool get isDraft => state == "draft";
  bool get isConfirmed => state == "confirm";
  bool get isCanceled => state == "cancel";
  bool get isDelivered => state == "delivered";

  static String? parseString(dynamic data) {
    if (data.runtimeType == bool) {
      return null;
    }
    return data.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.id;
    data['state'] = this.state;
    data['name'] = this.orderName;
    data['customer_name'] = this.customerName;
    data['pickup_name'] = this.pickupName;
    data['order_pickup_address'] = this.pickupAddress;
    data['pickup_mobile'] = this.pickUptMobile;
    data['dropoff_name'] = this.dropOffName;
    data['dropoff_address'] = this.dropOffAddress;
    data['dropoff_city'] = this.dropOffCity;
    data['dropoff_mobile'] = this.dropOffMobile;
    data['package_price'] = this.packagePrice;
    data['price'] = this.deliveryCharge;
    data['dropoff_mobile'] = this.dropOffMobile;
    data['paid_amount'] = this.paidAmount;
    data['collection_amount'] = this.collectionAmount;
    data['collected_amount'] = this.collectedAmount;
    data['balance'] = this.dropOffBalance;
    data['description'] = this.description;
    return data;
  }

  static List<OrderModel> ordersListFromJson(dynamic items) {
    if (items == null) return [];
    List<OrderModel> list = [];
    for (var json in items) {
      var order = OrderModel.fromJson(json);
      list.add(order);
    }
    return list;
  }

  void printOrder() {}

  void copy(OrderModel other) {
    state = other.state;
    orderName = other.orderName;
    customerName = other.customerName;
    pickupName = other.pickupName;
    pickupAddress = other.pickupAddress;
    pickUptMobile = other.pickUptMobile;
    dropOffName = other.dropOffName;
    dropOffAddress = other.dropOffAddress;
    dropOffCity = other.dropOffCity;
    packagePrice = other.packagePrice;
    deliveryCharge = other.deliveryCharge;
    dropOffMobile = other.dropOffMobile;
    paidAmount = other.paidAmount;
    collectionAmount = other.collectionAmount;
    collectedAmount = other.collectedAmount;
    dropOffBalance = other.dropOffBalance;
    description = other.description;
  }
}
