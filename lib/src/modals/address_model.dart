class AddressModel {
  int id;
  String? name;
  String? city;
  String? street;
  String? comment;
  AddressModel({
    required this.id,
    this.name,
    this.city,
    this.street,
    this.comment,
  });

  AddressModel.fromMap(Map<String, dynamic> json)
      : id = json['id'] == false ? 0 : json['id'],
        name = json['name'] == false ? "muller" : json['name'],
        city = json['city'] == false ? "" : json['city'],
        street = json['street'] == false ? "" : json['street'],
        comment = json['comment'] == false ? "" : json['comment'];
}
