import 'package:flutter/material.dart';
import 'package:orders_app/generated/l10n.dart';
import 'package:orders_app/src/modals/order_model.dart';
import 'package:orders_app/src/pages/orders/order_widget.dart';
import 'package:orders_app/src/widgets/spinner.dart';

class RouteSliverList extends StatelessWidget {
  final List<OrderModel> routes;
  final bool stopLoading;
  final bool hasError;
  final Function(OrderModel) onClick;
  final Function() loadMore;
  const RouteSliverList(
      {Key? key,
      required this.routes,
      required this.stopLoading,
      required this.onClick,
      required this.loadMore,
      this.hasError = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        if (index == routes.length) {
          if (hasError) {
            return ElevatedButton(
              child: Text(S.of(context).retry),
              onPressed: loadMore,
            );
          } else {
            return const Spinner();
          }
        }
        return OrderWidget(
          order: routes[index],
          onClick: onClick,
        );
      },
          childCount:
              stopLoading && !hasError ? routes.length : routes.length + 1),
    );
  }
}
