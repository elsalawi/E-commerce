import 'package:flutter/material.dart';
import 'package:orders_app/src/modals/customer_model.dart';
import 'package:orders_app/src/modals/response_modal.dart';
import 'package:orders_app/src/repository/customers_repository.dart';

class CustomersBloc extends ChangeNotifier {
  bool loading = true;
  List<CustomerModel> customers = [];

  void fetch() async {
    loading = true;
    notifyListeners();
    customers.clear();

    try {
      final _repo = CustomersRepository();
      ResponseModel responseModel = await _repo.fetch();
      print(responseModel.data);
      if (responseModel.isValid) {
        List customerList = responseModel.data['data']['partners'];
        for (var item in customerList) {
          customers.add(CustomerModel.fromMap(item));
        }
      } else {}
    } catch (e) {
      print(e);
    }
    loading = false;
    notifyListeners();
  }

  clear(){
    customers = [];
    loading = true;
  }
}
