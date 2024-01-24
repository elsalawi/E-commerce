import 'dart:io';

String getPlatformLocale() {
  final String defaultLocale = Platform.localeName;
  return defaultLocale.startsWith("ar") ? "ar" : "en";
}
