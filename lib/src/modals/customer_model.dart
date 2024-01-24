class CustomerModel {
  int id;
  String? name;
  double? balance;
  CustomerModel({
    required this.id,
    this.name,
    this.balance,
  });
  CustomerModel.fromMap(Map<String, dynamic> json)
      : id = json['customer_id'],
        name = json['name'],
        balance = double.parse(json['balance'].toString());
}
