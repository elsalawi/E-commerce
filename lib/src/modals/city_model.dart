class CityModel {
  int id;
  String? name;

  CityModel({required this.id, this.name});
  CityModel.fromMap(Map<String, dynamic> json)
      : id = json['id'] == false ? 0 : json['id'],
        name = json['name'] == "" ? "Unknown" : json['name'];
}
