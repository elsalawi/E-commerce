import 'package:flutter/material.dart';
import 'package:orders_app/src/bloc/orders_bloc.dart';
import 'package:orders_app/src/bloc/customers_block.dart';
import 'package:provider/provider.dart';

import '../auth_bloc.dart';
import '../language_bloc.dart';

class BlocProvider extends StatelessWidget {
  final Widget child;
  final LanguageBloc lang;
  const BlocProvider({
    Key? key,
    required this.child,
    required this.lang,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => lang),
        ChangeNotifierProvider(create: (context) => AuthBloc()),
        ChangeNotifierProvider(create: (context) => OrdersBloc()),
        ChangeNotifierProvider(create: (context) => CustomersBloc()),
      ],
      child: child,
    );
  }
}
