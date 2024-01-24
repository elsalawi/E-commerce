import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:orders_app/src/bloc/address_block.dart';
import 'package:orders_app/src/bloc/customers_block.dart';
import 'package:orders_app/src/bloc/language_bloc.dart';
import 'package:orders_app/src/bloc/orders_bloc.dart';
import 'package:orders_app/src/pages/change_language.dart';
import 'package:orders_app/src/utils/storage/storage_helper.dart';
import 'package:orders_app/src/utils/storage/storage_keys.dart';
import 'package:orders_app/src/values/colors.dart';
import 'package:orders_app/src/values/constants.dart';
import 'package:orders_app/src/widgets/nav/nav.dart';
import 'package:orders_app/src/widgets/profile_widgets.dart';
import 'package:orders_app/generated/l10n.dart';
import 'package:orders_app/src/widgets/spinner.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/extensions.dart';

import 'about_page.dart';
import 'change_avatar.dart';
import 'change_password.dart';
import 'login_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !isLoading;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).settings),
          leading: const BackButton(),
        ),
        body: isLoading
            ? const Spinner()
            : ListView(
                padding: const EdgeInsets.all(8),
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      S.of(context).general,
                      style: const TextStyle(color: primaryColor, fontSize: 14),
                    ),
                  ),
                  ListTile(
                    title: Text(S.of(context).language),
                    subtitle: const LanguageWidget(),
                    onTap: () => Navigator.of(context)
                        .push(NavSlideFromRight(page: ChangeLanguagePage())),
                  ),
                  const Divider(height: 16, thickness: 1),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      S.of(context).account,
                      style: const TextStyle(color: primaryColor, fontSize: 14),
                    ),
                  ),
                  ListTile(
                    title: Text(S.of(context).change_profile),
                    onTap: () => Navigator.of(context)
                        .push(NavSlideFromRight(page: ChangeProfilePage())),
                  ),
                  ListTile(
                    title: Text(S.of(context).change_password),
                    onTap: () => Navigator.of(context)
                        .push(NavSlideFromRight(page: const ChangePassword())),
                  ),
                  const Divider(height: 16, thickness: 1),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      S.of(context).about,
                      style: const TextStyle(color: primaryColor, fontSize: 14),
                    ),
                  ),
                  ListTile(
                    title: Text(S.of(context).about_application),
                    onTap: () => Navigator.of(context)
                        .push(NavSlideFromRight(page: AboutPage())),
                  ),
                  ListTile(
                    title: Text(S.of(context).help),
                    onTap: () => _openUrl(serverUrl),
                  ),
                  ListTile(
                    onTap: () => logout(),
                    title: Text(
                      S.of(context).sign_out,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  void _openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  void logout() async {
    setState(() {
      isLoading = true;
    });
    try {
      final partnerId = await StorageHelper.get(StorageKeys.partnerId);
      await FirebaseMessaging.instance
          .unsubscribeFromTopic("ch_$partnerId")
          .timeout(const Duration(seconds: 60));
    } catch (e) {}

    await context.provideOnly<OrdersBloc>().clear();
    await context.provideOnly<CustomersBloc>().clear();
    await StorageHelper.clear();
    await context.provideOnly<LanguageBloc>().setSystemLocale();
    setState(() {
      isLoading = false;
    });
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (Route<dynamic> route) => false);
  }
}
