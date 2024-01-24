import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:orders_app/src/bloc/orders_bloc.dart';
import 'package:orders_app/src/modals/address_model.dart';
import 'package:orders_app/src/modals/city_model.dart';
import 'package:orders_app/src/modals/order_model.dart';
import 'package:orders_app/src/pages/orders/create_orders.dart';
import 'package:orders_app/src/pages/orders/routes_points_list.dart';
import 'package:orders_app/src/values/colors.dart';
import 'package:orders_app/src/widgets/nav/nav.dart';
import 'package:provider/provider.dart';
import '../../../generated/l10n.dart' show S;

class OrdersPage extends StatefulWidget {
  final String title;
  final bool? isArchive;

  const OrdersPage({
    Key? key,
    required this.title,
    this.isArchive,
  }) : super(key: key);
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final ScrollController _controller = ScrollController();
  final List<OrderModel> _orders = [];
  late OrdersBloc _bloc;

//  get isArchive => null;

  @override
  void dispose() {  
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _bloc = Provider.of<OrdersBloc>(context, listen: false);
    _controller.addListener(_addScrollListeners);
    bool i = widget.isArchive == true ? true : false;
    _bloc.markItAsArchive(i);
    _bloc.fetch();
  }

  void _addScrollListeners() {
    if (_controller.position.userScrollDirection == ScrollDirection.reverse) {}
    if (_controller.position.userScrollDirection == ScrollDirection.forward) {}
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      _loadMore(false);
    }
  }

  Future<void> _loadMore(bool retry) async {
    Provider.of<OrdersBloc>(context, listen: false).loadMore(isRetry: retry);
  }

  Future<void> _refresh() async {
    Provider.of<OrdersBloc>(context, listen: false).refresh();
  }

  void _openDetails(OrderModel order) {
    Navigator.of(context).push(NavSlideFromRight(
        page: CreateOrderPage(order: order, isCreate: false)));
    // order: order, isCreate: false, isReadOnly: !order.isDraft)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final order = OrderModel(
            state: "draft",
            pickupAddress:
                AddressModel(id: 0, name: S.of(context).please_select_address),
            dropOffCity: CityModel(
              id: 0,
              name: S.of(context).please_select_city,
            ),
            id: 0,
          );
          Navigator.of(context).push(NavSlideFromRight(
              page: CreateOrderPage(
            order: order,
            isCreate: true,
          )));
        },
        child: const Icon(Icons.add),
        backgroundColor: accentColor,
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Scrollbar(
          child: CustomScrollView(
            controller: _controller,
            key: const PageStorageKey<String>("OrdersList"),
            slivers: <Widget>[
              SliverPadding(
                padding: const EdgeInsets.only(
                    left: 8, right: 8, top: 8, bottom: 64),
                sliver: RoutesPointsList(
                  bloc: _bloc,
                  openRoute: _openDetails,
                  onClick: _refresh,
                  loadMore: () => _loadMore(true),
                  routes: _orders,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
