import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:orders_app/src/utils/language.dart';
import 'package:orders_app/src/utils/storage/storage_helper.dart';
import 'package:orders_app/src/utils/storage/storage_keys.dart';

class LanguageBloc extends ChangeNotifier {
  Locale _appLocale = const Locale('en');

  Locale get appLocal => _appLocale;

  Future<void> setLocale() async {
    final code = await StorageHelper.get(StorageKeys.languageCode);
    if (code == null) {
      _appLocale = Locale(getPlatformLocale());
      return;
    }
    _appLocale = Locale(code);

//    _appLocale = Locale(code == null ? 'en' : code);
  }

  Future<void> setSystemLocale() async {
    final systemLocale = getPlatformLocale();
    await StorageHelper.set(StorageKeys.languageCode, systemLocale);
    _appLocale = Locale(systemLocale);
  }

  void changeLanguage(Locale locale) async {
    if (locale == const Locale("ar")) {
      _appLocale = const Locale("ar");
      StorageHelper.set(StorageKeys.languageCode, 'ar');
    } else {
      _appLocale = const Locale("en");
      StorageHelper.set(StorageKeys.languageCode, 'en');
    }
    notifyListeners();
  }

  bool get isArabic => appLocal == const Locale('ar');
  String get code => appLocal.languageCode;
}
