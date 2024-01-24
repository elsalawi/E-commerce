import 'package:flutter/material.dart';
import 'package:orders_app/src/pages/home_page.dart';
import 'package:orders_app/src/utils/storage/storage_helper.dart';
import 'package:orders_app/src/utils/storage/storage_keys.dart';
import 'package:orders_app/src/values/colors.dart';
import 'package:orders_app/src/widgets/nav/nav.dart';
import 'login_page.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    connect();
  }

  void connect() async {
    final isAuth = await StorageHelper.get(StorageKeys.auth);
    if (isAuth == null) {
      await Future.delayed(const Duration(seconds: 2));
      Navigator.of(context)
          .pushReplacement(NavSlideFromRight(page: const LoginPage()));
      return;
    } else {
      await Future.delayed(const Duration(seconds: 2));
      Navigator.of(context)
          .pushReplacement(NavSlideFromRight(page: const HomePage()));
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Image.asset(
          'assets/white.png',
          height: 72,
          width: 72,
        ),
      ),
    );
  }
}
