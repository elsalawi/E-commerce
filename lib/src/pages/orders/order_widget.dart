import 'package:flutter/material.dart';
import 'package:orders_app/generated/l10n.dart';
import 'package:orders_app/src/modals/order_model.dart';
import 'package:orders_app/src/pages/orders/cash_item.dart';
import 'package:orders_app/src/pages/orders/pickup_and_dropoff_widget.dart';
import 'package:orders_app/src/values/colors.dart';
import 'package:orders_app/src/widgets/card_view.dart';
import 'package:orders_app/src/widgets/text_styles.dart';

class OrderWidget extends StatelessWidget {
  final OrderModel order;
  final Function(OrderModel) onClick;
  const OrderWidget({
    Key? key,
    required this.order,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick(order),
      child: CardView(
        vrPadding: 20,
        hrPadding: 10,
        margin: const EdgeInsets.only(bottom: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Image.asset(
                  "assets/parcel.png",
                  color: primaryColor,
                  height: 18,
                  width: 18,
                ),
                const SizedBox(width: 8),
                Text("${order.orderName}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                Expanded(
                  child: Container(),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: order.isDraft ? Colors.green : Colors.blue,
                      borderRadius: const BorderRadius.all(Radius.circular(4))),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(order.state,
                      style:
                          const TextStyle(fontSize: 12, color: Colors.white)),
                )
              ],
            ),
            verticalDividerMedium,
            CashItem(
              title: S.of(context).customer,
              isLarge: true,
              value: order.customerName ?? S.of(context).unknown,
            ),
            verticalDividerMedium,
            PickupAndDropoffWidget(
              title: S.of(context).sender,
              name: order.pickupName,
              address: order.pickupAddress!.name,
              phone: order.pickUptMobile,
              isPickup: true,
            ),

            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              // child: Divider(),
            ),
//            verticalDividerMedium,
            //print home lan ....
            PickupAndDropoffWidget(
              title: S.of(context).receiver,
              name: order.dropOffName,
              address: "${order.dropOffCity!.name} - ${order.dropOffAddress}",
              phone: order.dropOffMobile,
              isPickup: false,
            ),
          ],
        ),
      ),
    );
  }
}
