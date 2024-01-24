import 'package:flutter/material.dart';
import 'package:orders_app/generated/l10n.dart';
import 'package:orders_app/src/bloc/orders_bloc.dart';
import 'package:orders_app/src/modals/event_source.dart';
import 'package:orders_app/src/modals/order_model.dart';
import 'package:orders_app/src/pages/orders/routeSliverList.dart';
import 'package:orders_app/src/widgets/empty.dart';
import 'package:orders_app/src/widgets/spinner.dart';

class RoutesPointsList extends StatelessWidget {
  final Function(OrderModel) openRoute;
  final Function() onClick;
  final Function() loadMore;
  final OrdersBloc bloc;
  final List<OrderModel> routes;
  const RoutesPointsList({
    Key? key,
    required this.bloc,
    required this.openRoute,
    required this.routes,
    required this.onClick,
    required this.loadMore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EventSource<OrderModel>>(
      initialData: EventSource(data: [], loading: true),
      stream: bloc.event,
      builder: (context, snapshot) {
        EventSource? model = snapshot.data;
        if ((model == null && routes.isEmpty) ||
            (model!.loading && routes.isEmpty)) {
          return const SliverSpinner();
        }

        if (model.hasError && routes.isEmpty) {
          return SliverToBoxAdapter(
            child: DataErrorMessageWidget(
              text: snapshot.data!.error!,
              onClick: onClick,
            ),
          );
        }
        if (model.hasData && !model.refresh) {
          for (final item in (model.data as List<OrderModel>)) {
            if (routes.indexWhere((order) => order.id == item.id) == -1) {
              if (model.meta != null && model.meta == "insert") {
                routes.insert(0, item);
              } else {
                routes.add(item);
              }
            }
          }
        }
        if (model.hasError && !model.hasData && routes.isNotEmpty) {
          return RouteSliverList(
              routes: routes,
              loadMore: loadMore,
              hasError: true,
              onClick: (OrderModel route) => openRoute(route),
              stopLoading: model.stopLoading);
        }

        if (model.hasData && model.refresh) {
          routes.clear();
          routes.addAll(model.data as List<OrderModel>);
        }
        if (routes.isEmpty && !model.refresh) {
          return SliverToBoxAdapter(
            child: EmptyWidget(
              text: S.of(context).empty_order,
            ),
          );
        }
        return RouteSliverList(
          routes: routes,
          onClick: (OrderModel route) => openRoute(route),
          stopLoading: model.stopLoading || model.refresh,
          loadMore: loadMore,
        );
      },
    );
  }
}
