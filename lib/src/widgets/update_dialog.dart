import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:orders_app/generated/l10n.dart';
class UpdateDialog extends StatelessWidget {
  const UpdateDialog({Key? key}) : super(key: key);

  _launchStore() async {
    SystemNavigator.pop();
    //   await clearAllSharedValue();
    // isLoggedIn = false;
    String url =
        "http://play.google.com/store/apps/details?id=com.fatish.sdecommerce";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: AlertDialog(
          contentPadding: EdgeInsets.zero,
          title: Text(S.of(context).update_app),
          actions: <Widget>[
            FlatButton(
              color: Colors.black,
              child: Text(
                S.of(context).close_app.toUpperCase(),
              ),
              onPressed: () {
                SystemNavigator.pop();
              },
            ),
            FlatButton(
              color: Colors.green,
              child: Text(
                S.of(context).update_now.toUpperCase(),
//                  style: TextStyle(color: Colors.green),
              ),
              onPressed: () {
                _launchStore();
                Navigator.of(context).pop();
              },
            ),
          ],
          content: Container(
            padding: const EdgeInsets.all(25),
            child: Text(
              S.of(context).update_app_message,
            ),
            // color: Colors.blue,
            // child:
          ),
        ),
      ),
    );
  }
}
