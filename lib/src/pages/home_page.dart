import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:orders_app/src/modals/base.dart';
import 'package:orders_app/src/modals/notification.dart';
import 'package:orders_app/src/pages/about_page.dart';
import 'package:orders_app/src/pages/home_page_options.dart';
import 'package:orders_app/src/values/colors.dart';
import 'package:orders_app/src/values/constants.dart';
import 'package:orders_app/src/widgets/nav/nav.dart';
import 'package:orders_app/src/widgets/profile_widgets.dart';
import 'package:orders_app/src/widgets/snackbar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:orders_app/generated/l10n.dart';
import 'settings_page.dart';
import 'package:orders_app/src/widgets/update_dialog.dart';
import 'package:provider/provider.dart';
import 'package:orders_app/src/bloc/auth_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime? currentPressTime;

  showNotification(BuildContext context, String title, String body) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: CustomSnackbar(body: title, title: body),
      backgroundColor: primaryColor,
      behavior: SnackBarBehavior.floating,
    ));
  }

  Future<T?> _handleNotification<T>(RemoteMessage? message,
      {bool show = false}) async {
    T? model;
    try {
      if (message != null) {
        final raw = RawNotification.fromJson(message.data);
        final data = raw.parseData();
        String? title, body;
        if (raw.hasModel && raw.model == "notification" && data != null) {
          title = raw.title;
          body = raw.body;
          final notification = NotificationModel.fromJson(data);
          model = notification as T;
        }
        if (raw.hasModel && raw.model == "route" && data != null) {
          /// Parse data
          final notif = NotificationModel.fromNotificationJson(data);
          notif.parseMeta();

          /// Make message
          title = S.of(context).route_notification_title(data["name"]);
          body = S.of(context).route_notification_body(data["state"]);

          model = Annonymous(id: 1) as T;
        }

        if (show && title != null && body != null) {
          showNotification(context, title, body);
        }
      }
    } catch (e) {}
    if (model != null) {}

    return model;
  }

  _handleOnMessage(RemoteMessage message) async {
    final model = await _handleNotification(message, show: true);
  }

  _handleOnOpen(RemoteMessage message) async {
    final model = await _handleNotification(message);
  }

  _onInitialMessage(RemoteMessage? message) async {
    final model = await _handleNotification(message);
  }

  @override
  void initState() {
    print("=========== ${DateTime.now()}" );
    super.initState();
    checkForUpdates();
    FirebaseMessaging.onMessage.listen(_handleOnMessage);
    FirebaseMessaging.instance.getInitialMessage().then(_onInitialMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleOnOpen);
  }

  void _openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  void checkForUpdates() async {
    bool check =
        await Provider.of<AuthBloc>(context, listen: false).checkForUpdates();
    // if (check) UpdateDialog();
    if (check) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return UpdateDialog();
        },
      );
    }
  }

  void _settingModalBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Wrap(
          children: <Widget>[
            Container(
              color: Colors.grey[200],
              padding:
                  const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 8),
              child: Row(
                children: const <Widget>[
                  ProfileImageWidget(),
                  NameWidget(),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              title: Text(S.of(context).settings),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context)
                    .push(NavSlideFromRight(page: SettingsPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              title: Text(S.of(context).about),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context)
                    .push(NavSlideFromRight(page: AboutPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.help_outline),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              title: Text(S.of(context).help),
              onTap: () {
                Navigator.of(context).pop();
                _openUrl(serverUrl);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: _settingModalBottomSheet,
          ),
          title: Text(S.of(context).app),
        ),
        body: const HomePageOptions(),
      ),
    );
  }

  _showMessage(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }
  }
}
