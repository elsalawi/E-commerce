import 'package:flutter/material.dart';
import 'package:orders_app/generated/l10n.dart';
import 'package:orders_app/src/bloc/orders_bloc.dart';
import 'package:orders_app/src/pages/customers_page.dart';
import 'package:orders_app/src/pages/notifications_page.dart';
import 'package:orders_app/src/pages/orders/orders_page.dart';
import 'package:orders_app/src/pages/orders/accounting_page.dart';
import 'package:orders_app/src/values/colors.dart';
import 'package:orders_app/src/widgets/nav/nav.dart';
import 'package:provider/provider.dart';

class HomePageOptions extends StatelessWidget {
  const HomePageOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final translate = S.of(context);
    List<Item> items = [
      Item(
        title: translate.orders,
        icon: Icons.featured_play_list_outlined,
        navPage: OrdersPage(title: translate.orders),
      ),
      Item(
          title: S.of(context).customers,
          icon: Icons.person_outline,
          navPage: const CustomerPage()),
      Item(
          title: S.of(context).accounting,
          icon: Icons.account_balance_outlined,
          navPage: const Accounting()),
      Item(
        title: S.of(context).archive,
        icon: Icons.archive_outlined,
        navPage: OrdersPage(
          title: translate.orders,
          isArchive: true,
        ),
      ),
      Item(
        title: S.of(context).notifications,
        icon: Icons.notifications_outlined,
        navPage: const NotificationsPage(),
      ),
    ];
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: (1 / .8),
      ),
      itemBuilder: (_, index) => itemWidget(context, items[index]),
      itemCount: items.length,
    );
  }

  Widget itemWidget(BuildContext context, Item item) => GestureDetector(
        onTap: () {
          if (item.title.toLowerCase() == S.of(context).orders.toLowerCase()) {
            Provider.of<OrdersBloc>(context, listen: false)
                .setIsCustomerOder(false);
          }
          Navigator.of(context).push(NavSlideFromRight(page: item.navPage));
        },
        child: Card(
          color: primaryColor,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(item.icon, size: 42, color: Colors.white),
                  const SizedBox(height: 10),
                  Text(
                    item.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      );
}

class Item {
  IconData icon;
  String title;
  bool? isArchive;
  Widget navPage;

  Item({
    required this.title,
    required this.icon,
    required this.navPage,
    this.isArchive,
  });
}
