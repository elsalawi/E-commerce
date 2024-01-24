import 'dart:async';

import 'package:flutter/material.dart';
import 'package:orders_app/generated/l10n.dart';
import 'package:orders_app/src/bloc/auth_bloc.dart';
import 'package:orders_app/src/utils/validators.dart';
import 'package:orders_app/src/values/colors.dart';
import 'package:orders_app/src/widgets/spinner.dart';
import 'package:orders_app/src/widgets/text_styles.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true, _obscureText1 = true;
  String? oldPassword, newPassword;
  StreamSubscription<String>? _subscription;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final _bloc = Provider.of<AuthBloc>(context);
    _subscription = _bloc.errorMessage.listen((message) async {
      if (message == null || message.isEmpty || message == "CLEAR") return;
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

  void save() async {
    if (_formKey.currentState!.validate()) {
//      var connectivityResult = await (Connectivity().checkConnectivity());
//      if (connectivityResult == ConnectivityResult.none) {
//        CustomToast.show(S.of(context).no_internet_connection);
//      } else {
//        setLloading(true);
//        final repo = AuthRepository();
//        final response =
//        await repo.changePassword(_oldPasswordValue, _newPasswordValue);
//        setLloading(false);
//        if (response.success) {
//          CustomToast.show(S.of(context).password_update_successfully);
//        } else {
//          CustomToast.show(S.of(context).invalid_info);
//        }
//      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<AuthBloc>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).change_password),
          leading: const BackButton(),
        ),
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(8),
              shrinkWrap: true,
              children: <Widget>[
                Text(S.of(context).old_password,
                    style: accentTextStyleMediumDark),
                verticalDividerSmall,
                TextFormField(
                  autofocus: false,
                  obscureText: _obscureText,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: S.of(context).old_password,
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        semanticLabel: _obscureText
                            ? S.of(context).show_password
                            : S.of(context).hide_password,
                      ),
                    ),
                  ),
                  validator: FormValidator.validatePassword,
                  onSaved: (String? value) {
                    oldPassword = value;
                  },
                ),
                verticalDividerMedium,
                Text(S.of(context).new_password,
                    style: accentTextStyleMediumDark),
                verticalDividerSmall,
                TextFormField(
                  autofocus: false,
                  obscureText: _obscureText1,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: S.of(context).new_password,
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText1 = !_obscureText1;
                        });
                      },
                      child: Icon(
                        _obscureText1 ? Icons.visibility : Icons.visibility_off,
                        semanticLabel: _obscureText1
                            ? S.of(context).show_password
                            : S.of(context).hide_password,
                      ),
                    ),
                  ),
                  validator: FormValidator.validatePassword,
                  onSaved: (String? value) {
                    newPassword = value;
                  },
                ),
                const SizedBox(height: 24),
                MaterialButton(
                  color: accentColor,
                  height: 48.0,
                  elevation: 1,
                  onPressed: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      showProgress();
                      final res = await _bloc.changePassword(
                          oldPassword!, newPassword!);
                      Navigator.of(context).pop();
                      if (res) {
                        _showMessage(
                            S.of(context).password_changed_successfully);
                      }
                    }
                  },
                  child: Text(
                    S.of(context).change,
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
    );
  }

  void showProgress() {
    showDialog<dynamic>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Dialog(
                backgroundColor: Colors.white,
                insetAnimationDuration: Duration(milliseconds: 100),
                elevation: 2,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(2))),
                child: SizedBox(
                  height: 120,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const <Widget>[
                        Spinner(),
                        verticalDividerSmall,
                        Text("Please wait")
                      ],
                    ),
                  ),
                )),
          );
        });
  }
}
