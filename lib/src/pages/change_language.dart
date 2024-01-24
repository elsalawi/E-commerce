import 'package:flutter/material.dart';
import 'package:orders_app/generated/l10n.dart';
import 'package:orders_app/src/bloc/language_bloc.dart';
import 'package:orders_app/src/utils/storage/storage_helper.dart';
import 'package:orders_app/src/utils/storage/storage_keys.dart';
import 'package:orders_app/src/widgets/text_styles.dart';

import '../utils/extensions.dart';

class ChangeLanguagePage extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<ChangeLanguagePage> {
  bool notification = false;

  Future checkIsFirstTime() async {
    final isFirst = await StorageHelper.get(StorageKeys.notification);

    if (isFirst == null || isFirst == "no") {
      notification = false;
    } else {
      notification = true;
    }
  }

  @override
  void initState() {
    checkIsFirstTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
//        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          title: Text(S.of(context).choose_language),
        ),
        body: Container(
          margin: EdgeInsets.only(left: 16, right: 16),
          child: _buildListView(context),
        ),
      ),
    );
  }

  Widget _buildListView(BuildContext context) {
    return Center(
      child: FutureBuilder<String?>(
        initialData: "en",
        future: StorageHelper.get(StorageKeys.languageCode),
        builder: (context, snapshot) {
          return ListView(
            children: <Widget>[
              ListTile(
                trailing: snapshot.data != "ar" ? Icon(Icons.check) : null,
                onTap: () {
                  update("en");
                },
                title: Text(
                  S.of(context).english,
                  style: accentTextStyleSmallDarkBold,
                ),
              ),
              Divider(color: Colors.grey[200], thickness: 1, height: 4),
              ListTile(
                onTap: () {
                  update("ar");
                },
                title: Text(
                  S.of(context).arabic,
                  style: accentTextStyleSmallDarkBold,
                ),
                trailing: snapshot.data == "ar" ? Icon(Icons.check) : null,
              ),
            ],
          );
        },
      ),
    );
  }

  void update(String code) async {
    final bloc = context.provideOnly<LanguageBloc>();
    bloc.changeLanguage(Locale(code));
  }
}
