import 'package:flutter/material.dart';
import 'package:orders_app/generated/l10n.dart';
import 'package:orders_app/src/bloc/customers_block.dart';
import 'package:orders_app/src/bloc/orders_bloc.dart';
import 'package:orders_app/src/modals/customer_model.dart';
import 'package:orders_app/src/pages/orders/orders_page.dart';
import 'package:orders_app/src/utils/extensions.dart';
import 'package:orders_app/src/values/colors.dart';
import 'package:orders_app/src/widgets/nav/nav.dart';
import 'package:provider/provider.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({Key? key}) : super(key: key);

  @override
  _CustomerPageState createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<CustomersBloc>(context, listen: false)
        .fetch());
  }
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<CustomersBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).customers),
        backgroundColor: primaryColor,
      ),
      body: Center(
        child: _bloc.loading
            ? const CircularProgressIndicator(strokeWidth: 2)
            : buildCustomersWidget(_bloc),
      ),
    );
  }

  Widget buildCustomersWidget(CustomersBloc bloc) {
    return GridView.builder(
      itemCount: bloc.customers.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
      ),
      itemBuilder: (BuildContext context, int index) {
        return customerWidget(bloc.customers[index]);
      },
    );
  }

  Widget buildCustomersWidget2(CustomersBloc bloc) {
    return Scrollbar(
      child: ListView.builder(
        itemCount: bloc.customers.length,
        itemBuilder: (BuildContext context, index) {
          return customerWidget(bloc.customers[index]);
        },
      ),
    );
  }

  Widget customerWidget(CustomerModel customer) {
    return InkWell(
      onTap: () {
        Provider.of<OrdersBloc>(context, listen: false).setIsCustomerOder(true);
        Provider.of<OrdersBloc>(context, listen: false)
            .setCustomerId(customer.id);
        Navigator.of(context).push(NavSlideFromRight(
            page: OrdersPage(
          title: "${S.of(context).orders} - ${customer.name}",
        )));
      },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(customer.name!),
            const SizedBox(height: 10),
            Text(
                " ${S.of(context).balance}: ${currencyFormat(customer.balance!)}"),
          ],
        ),
      ),
    );
  }
}
