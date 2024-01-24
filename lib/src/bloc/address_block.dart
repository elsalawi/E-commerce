import 'package:flutter/material.dart';
import 'package:orders_app/src/modals/address_model.dart';
import 'package:orders_app/src/modals/city_model.dart';
import 'package:orders_app/src/modals/customer_model.dart';
import 'package:orders_app/src/modals/response_modal.dart';
import 'package:orders_app/src/repository/address_repository.dart';

class AddressBlock extends ChangeNotifier {
  List<AddressModel> address = [];
  void fetch() async {
    final _repo = AddressRepository();
    ResponseModel responseModel = await _repo.fetchPickupAddress();
    List demo = responseModel.data['data']['addresses'] as List;

    demo.map((e) => address.add(AddressModel.fromMap(e)));
    notifyListeners();
    print(responseModel.data);
  }

  Future<List<AddressModel>> pickUpAddress() async {
    List<AddressModel> _address = [];
    final _repo = AddressRepository();
    ResponseModel responseModel = await _repo.fetchPickupAddress();
    List demo = responseModel.data['data']['addresses'] as List;

    print("999999999999999999999");
    // print(demo);
//    demo.map((e) => _address.add(AddressModel.fromMap(e)));

    demo.forEach((element) {
      _address.add(AddressModel.fromMap(element));
    });
    print(_address.length);
    print(";;;;;;;;;;;;;;;;;;;;;;;;");
//    });
    return _address;
  }
Future<List<CityModel>> dropOffCities() async {
    List<CityModel> _cities = [];
    final _repo = AddressRepository();
    ResponseModel responseModel = await _repo.fetchDropOffCities();
    print("999999999999999999999");
    print(responseModel.data);
    List demo = responseModel.data['data']['cities'] as List;
    // print(demo);
//    demo.map((e) => _address.add(AddressModel.fromMap(e)));

    demo.forEach((element) {
      _cities.add(CityModel.fromMap(element));
    });
    print(_cities.length);
    print(";;;;;;;;;;;;;;;;;;;;;;;;");
//    });
    return _cities;
  }

  List<String> customPickUpAddress(List<AddressModel> pickupAddress) {
    List<String> _address = [];
    pickupAddress.forEach((AddressModel element) {
      _address.add(element.name! + element.city! + element.street!);
    });
    return _address;
  }

  Future<void > clear() async{
    address = [];
  }
}
