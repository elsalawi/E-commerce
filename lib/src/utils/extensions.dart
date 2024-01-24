import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:intl/intl.dart';

extension ProviderExtension<T> on BuildContext {
  T provide<T>() => Provider.of<T>(this);
  T provideOnly<T>() => Provider.of<T>(this, listen: false);
}

extension StringInputExtension on String {
  /// Returns `'true' if string match name pattern.
  bool isValidName() {
//    print(object);
    String pattern = r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(this);
  }

  /// Returns `'true' if string match mobile pattern.
  bool isValidMobile() {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(trim());
  }

  /// Checks if string is float.
  ///
  /// Returns 'false' if string is not valid floar string value
  bool isFloat() {
    try {
      double.parse(trim());
      return true;
    } catch (e) {}
    return false;
  }

  /// Checks if string is int.
  ///
  /// Returns 'false' if string is not valid double string value
  bool isInt() {
    try {
      int.parse(trim());
      return true;
    } catch (e) {}
    return false;
  }

  /// Convert string to double.
  ///
  /// Returns [null] if string is not valid double string value
  double? toDouble() {
    try {
      return double.parse(trim());
    } catch (e) {}
    return null;
  }

  /// Convert string to int.
  ///
  /// Returns [null] if string is not valid int string value
  int? toInt() {
    try {
      return int.parse(trim());
    } catch (e) {}
    return null;
  }

  /// Convert string to Datetime object.
  ///
  /// Returns [null] if string is not valid datetime string value
  DateTime? toDate() {
    try {
      final date = DateTime.parse(trim());
      return date;
    } catch (e) {}
    return null;
  }

  /// Convert string to boolean object.
  ///
  /// Returns `false` if string is not boolean string value or string is [null]
  bool toBoolean() => this == null
      ? false
      : this == "false"
          ? false
          : true;
}

String currencyFormat(double currency) {
  final oCcy = new NumberFormat("#,##0", "en_US");
  return oCcy.format(currency);
}
