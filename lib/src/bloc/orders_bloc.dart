import 'package:orders_app/src/modals/event_source.dart';
import 'package:orders_app/src/modals/order_model.dart';
import 'package:orders_app/src/modals/pagination_model.dart';
import 'package:orders_app/src/modals/response_modal.dart';
import 'package:orders_app/src/repository/orders_repository.dart';
import 'package:orders_app/src/utils/exceptions/custom_exceptions.dart';
import 'package:orders_app/src/utils/storage/storage_helper.dart';
import 'package:orders_app/src/utils/storage/storage_keys.dart';
import 'package:rxdart/rxdart.dart';

import 'base/bloc_base.dart';

class OrdersBloc extends BlocBase {
  final _eventSource = BehaviorSubject<EventSource<OrderModel>>();
  Stream<EventSource<OrderModel>> get event =>
      _eventSource.stream.asBroadcastStream();
  void setEvent(EventSource<OrderModel> event) => _eventSource.sink.add(event);

  PaginationModel? pager;

  bool _lock = false;
  bool get lock => _lock;
  set setLock(bool lck) => _lock = lck;
  String? price;
  bool _isCustomerOder = false;
  bool _isArchive = false;
  int _customerId = 1;

  void setIsCustomerOder(bool flag) {
    _isCustomerOder = flag;
    notifyListeners();
  }

  void markItAsArchive(bool flag) {
    _isArchive = flag;
  }

  void setIsArchive(bool flag) {
    _isArchive = flag;
    notifyListeners();
  }

  bool get geIsCustomerOder => _isCustomerOder;
  bool get getIsArchive => _isArchive;
  void setCustomerId(int id) => _customerId = id;
  int get getCustomerId => _customerId;


  Future<void> init() async {
    price = await StorageHelper.get(StorageKeys.defaultPrice);
  }

  Future<void> fetch() async {
    setEvent(EventSource(data: [], loading: true));

    print("fetch 1");
    final _repo = OrdersRepository();
    ResponseModel responseModel = await _repo.getOrders(
        isCustomerOrders: _isCustomerOder, customerId: _customerId, isArchive: _isArchive);
    print("fetch 2");
    if (responseModel.status == 500) {
      responseModel = await _repo.getOrders(
          isCustomerOrders: _isCustomerOder, customerId: _customerId, isArchive: _isArchive);
    }
    if (!responseModel.success && responseModel.status == 1105) {
      setEvent(EventSource(data: [], loading: false));
    } else if (responseModel.isValid) {
      print("responseModel.data['data']");
      print(responseModel);
      print(responseModel.data['delivery_orders']);
      pager = PaginationModel.fromMap(responseModel.data);
      final rts = pager!.data as List<OrderModel>;


      setEvent(EventSource(
          loading: false,
          data: rts,
          error: null,
          stopLoading: !pager!.hasNext));
    } else {
      setEvent(EventSource(
          loading: false,
          data: null,
          error: responseModel.message));
    }
  }

  Future<void> refresh() async {

    setEvent(EventSource(data: [], loading: true, refresh: true));
//    setEvent(new EventSource(
//        data: pager.data as List<OrderModel>, loading: true, refresh: true));
    final _repo = OrdersRepository();
    final ResponseModel responseModel = await _repo.getOrders(
        isCustomerOrders: _isCustomerOder, customerId: _customerId, isArchive: _isArchive);
    if (!responseModel.success && responseModel.status == 1105) {
      setEvent(EventSource(data: [], loading: false));
    } else if (responseModel.isValid) {
      pager = PaginationModel.fromMap(responseModel.data);
      final rts = pager!.data as List<OrderModel>;
      setEvent(EventSource(
          loading: false,
          data: rts,
          error: null,
          stopLoading: !pager!.hasNext));
    } else if (responseModel.isValid) {
      setEvent(EventSource(loading: false, data: null));
    } else {
      setEvent(EventSource(
          loading: false,
          data: null,
          error: responseModel.message));
    }
  }

  Future<void> loadMore({bool isRetry = false}) async {

    if (!lock && pager != null && pager!.hasNext) {
      setLock = true;
      if (isRetry) {
        setEvent(new EventSource(data: [], loading: false, stopLoading: false));
      }
      final _repo = OrdersRepository();
      final responseModel = await _repo.loadMore(pager!.nextPage!);
      if (!responseModel.success && responseModel.status == 1105) {
        setEvent(EventSource(data: [], loading: false));
      } else if (responseModel.isValid) {
        pager = PaginationModel.fromMap(responseModel.data);
        final rts = pager!.data as List<OrderModel>;
        setEvent(EventSource(
            loading: false,
            data: rts,
            error: null,
            stopLoading: !pager!.hasNext));
      } else if (responseModel.isValid) {
        setEvent(EventSource(
            loading: false,
            data: null,
            stopLoading: !pager!.hasNext,
            error: responseModel.message));
      } else {
        setEvent(EventSource(
            loading: false,
            data: null,
            stopLoading: !pager!.hasNext,
            error: responseModel.message));
      }
      setLock = false;
    }
  }

  Future<OrderModel?> createOrder(OrderModel orderModel) async {

    final _repo = OrdersRepository();
    try {
      final res = await _repo.create(orderModel).timeout(const Duration(minutes: 1));
      if (res.success) {
        final order = OrderModel.fromJson(res.data);
        setEvent(EventSource(
            loading: false, data: [order], refresh: false, error: null, meta: "insert"));
        print("create returned data ...... ");
        print(res.data);
        return order;
        // return OrderModel.fromJson(res.data['order_data']);
        // return true;
      } else {
        setError(res.message);
        return null;
      }
    } catch (e) {
      setError(CustomException.errorMessage(e).message);
    }
    return null;
  }

  Future<OrderModel?> updateOrder(OrderModel orderModel) async {

    final _repo = OrdersRepository();
    try {
      final res = await _repo.update(orderModel).timeout(Duration(minutes: 1));
      if (res.success) {
        notifyListeners();
        // return OrderModel();
        // return OrderModel.fromJson(res.data);
        print("muller -------------------------------------------------");
        print(res.data);
        print("muller -------------------------------------------------");
        return OrderModel.fromJson(res.data['order_data']);

      } else {
        setError(res.message);
      }
    } catch (e) {
      print("exception ......");
      print(e);
      setError(CustomException.errorMessage(e).message);
    }
    return null;
  }

  Future<bool> getDefaults() async {
    setLoading(true);

    try {
      final _repo = OrdersRepository();
      final res = await _repo.getDefaults().timeout(Duration(minutes: 1));
      setLoading(false);
      if (res.success && (res.data as Map).containsKey("price")) {
        final pr = res.data["price"];
        await StorageHelper.set(StorageKeys.defaultPrice, pr.toString());
      } else {
        setError(res.message);
      }
    } catch (e) {
      setLoading(false);
      setError(CustomException.errorMessage(e).message);
    }
    return false;
  }

  @override
  void dispose() {
    super.dispose();
    _eventSource.close();
  }

  Future<void> clear() async {
    setEvent(EventSource(loading: true, data: [], refresh: false, error: null));
  }

}