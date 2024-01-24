import 'package:flutter/material.dart';
import 'package:orders_app/generated/l10n.dart';
import 'package:orders_app/src/bloc/customers_block.dart';
import 'package:orders_app/src/bloc/orders_bloc.dart';
import 'package:orders_app/src/modals/customer_model.dart';
import 'package:orders_app/src/pages/customer_accounting_details.dart';
import 'package:orders_app/src/utils/extensions.dart';
import 'package:orders_app/src/values/colors.dart';
import 'package:orders_app/src/widgets/nav/nav.dart';
import 'package:provider/provider.dart';

class Accounting extends StatefulWidget {
  const Accounting({Key? key}) : super(key: key);

  @override
  _AccountingState createState() => _AccountingState();
}

class _AccountingState extends State<Accounting> {

  CustomersBloc? _bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() {
      final bloc = Provider.of<CustomersBloc>(context, listen: false);
      bloc.fetch();
    });
  }

  @override
  Widget build(BuildContext context) {
    _bloc = Provider.of<CustomersBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).accounting),
        backgroundColor: primaryColor,
      ),
      body: Center(
        child: _bloc!.loading
            ? const CircularProgressIndicator(strokeWidth: 2)
            : buildAccountingWidget(),
      ),
    );
  }

  Widget buildAccountingWidget() {
    return GridView.builder(
      itemCount: _bloc!.customers.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
      ),
      itemBuilder: (BuildContext context, int index) {
        return accountingWidget(_bloc!.customers[index]);
      },
    );
  }

  Widget buildCustomersWidget2() {
    return Scrollbar(
      child: ListView.builder(
        itemCount: _bloc!.customers.length,
        itemBuilder: (BuildContext context, index) {
          return accountingWidget(_bloc!.customers[index]);
        },
      ),
    );
  }

  Widget accountingWidget(CustomerModel customer) {
    return InkWell(
      onTap: () {
        Provider.of<OrdersBloc>(context, listen: false).setIsCustomerOder(true);
        Provider.of<OrdersBloc>(context, listen: false)
            .setCustomerId(customer.id);
        Navigator.of(context).push(NavSlideFromRight(
            page: WebViewExample(customerId: customer.id
//              title: "${S.of(context).orders} - ${customer.name}",
                )));
      },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(customer.name!),
            SizedBox(height: 10),
            Text(
                " ${S.of(context).balance}: ${currencyFormat(customer.balance!)}"),
          ],
        ),
      ),
    );
  }
}
