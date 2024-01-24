import 'dart:async';

import 'package:flutter/material.dart';
import 'package:orders_app/generated/l10n.dart';
import 'package:orders_app/src/bloc/auth_bloc.dart';
import 'package:orders_app/src/utils/storage/storage_helper.dart';
import 'package:orders_app/src/utils/storage/storage_keys.dart';
import 'package:orders_app/src/utils/validators.dart';
import 'package:orders_app/src/values/colors.dart';
import 'package:orders_app/src/widgets/loading.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  StreamSubscription<String>? _subscription;
  DateTime? currentPressTime;
  String? password, login;

  @override
  void initState() {
    super.initState();
    final _bloc = Provider.of<AuthBloc>(context, listen: false);
    _subscription = _bloc.errorMessage.listen((message) async {
      if (message.isEmpty || message == "CLEAR") return;
      await Future.delayed(const Duration(milliseconds: 200));
      _showMessage(message);
    });
  }

  _showMessage(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<AuthBloc>(context);

    return WillPopScope(
      onWillPop: () {
        final DateTime now = DateTime.now();
        if (currentPressTime == null ||
            now.difference(currentPressTime!) > const Duration(seconds: 2)) {
          currentPressTime = now;
          _showMessage(S.of(context).double_click_exit);
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: Scaffold(
        body: SafeArea(
          child: Loading(
            message: S.of(context).please_wait,
            status: _bloc.loading,
            backgroundTransparent: false,
            child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: <Widget>[
                  Image.asset(
                    'assets/logo.png',
                    height: 72,
                    width: 72,
                  ),
                  const SizedBox(height: 50.0),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    autofocus: false,
                    decoration: InputDecoration(
                      hintText: S.of(context).username,
                      contentPadding:
                          const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                    ),
                    validator: FormValidator.validateUsername,
                    onSaved: (String? value) {
                      login = value;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    autofocus: false,
                    obscureText: _obscureText,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: S.of(context).password,
                      contentPadding:
                          const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          semanticLabel: _obscureText
                              ? S.of(context).show_password
                              : S.of(context).hide_password,
                        ),
                      ),
                    ),
                    validator: FormValidator.validatePassword,
                    onSaved: (String? value) {
                      password = value;
                    },
                  ),
                  const SizedBox(height: 64),
                  MaterialButton(
                    color: primaryColor,
                    height: 48.0,
                    elevation: 1,
                    onPressed: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        final res = await _bloc.login(login!, password!);
                        print("=========== ${DateTime.now()}" );
                        if (res) {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()),
                              (Route<dynamic> route) => false);
                        }
                      }
                    },
                    child: Text(
                      S.of(context).login,
                      style: const TextStyle(color: Colors.white),
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
