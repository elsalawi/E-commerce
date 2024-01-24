import 'dart:async';

import 'package:orders_app/generated/l10n.dart';
import 'package:validators/validators.dart';

import 'extensions.dart';

class Validators {
  final emailValidation =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email.contains("@") || email == "") {
      sink.add(email);
    } else {
      sink.addError(S.current.email_invalid);
    }
  });

  final passwordValidation = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if ((password.length > 1 && password.length < 20) || password.length == 0) {
      sink.add(password);
    } else {
      sink.addError(S.current.password_invalid);
    }
  });

  final nameValidation =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.length > 5 || name.length == 0 || isAlphanumeric(name)) {
      sink.add(name);
    } else {
      sink.addError(S.current.name_invalid);
    }
  });
  final phoneValidation =
      StreamTransformer<String, String>.fromHandlers(handleData: (phone, sink) {
    if (!isNumeric(phone)) {
      sink.addError(S.current.digits_only);
    }
    if (phone.length > 0 && phone.length < 10) {
      sink.addError(S.current.phone_digits_10);
    }
    if (phone.length == 9 || phone.length == 0) {
      sink.add(phone);
    } else {
      sink.addError(S.current.invalid_phone);
    }
  });
}

class FormValidator {
  static String? validatePassword(String? value) {
    if (value != null && value.isEmpty) {
      return S.current.password_required;
    }
    return null;
  }

  static String? validateEmail(String value) {
    String pattern =
        r'^(([^&lt;&gt;()[\]\\.,;:\s@\"]+(\.[^&lt;&gt;()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return S.current.email_required;
    } else if (!regExp.hasMatch(value)) {
      return S.current.email_invalid;
    } else {
      return null;
    }
  }

  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return S.current.username_required;
    } else {
      return null;
    }
  }

  static String? validateName(String? value) {
    String pattern = r"^[\u0621-\u064Aa-zA-Z\s]*$";
    RegExp regExp = new RegExp(pattern);
    if (value == null || value.isEmpty) {
      return S.current.name_required;
    } else if (!regExp.hasMatch(value)) {
      return S.current.name_invalid;
    } else {
      return null;
    }
  }

  static String? validName(String? value) {
    if (value == null || value.isEmpty) {
      return S.current.name_required;
    } else {
      return null;
    }
  }

  static String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return S.current.address_required;
    } else if (value.length < 3) {
      return S.current.invalid_Address;
    } else {
      return null;
    }
  }

  static String? validatePhone(String value) {
    String pattern = r"/^(\+\d{1,3}[- ]?)?\d{10}$/";
    RegExp regExp = new RegExp(pattern);
    if (value.isEmpty) {
      return S.current.phone_Required;
    } else if (!regExp.hasMatch(value) || value.length != 9) {
      return S.current.invalid_phone;
    } else if (value.length == 10) {
      return S.current.phone_with_no_zero;
    } else if (value.length != 9) {
      return S.current.invalid_phone;
    } else {
      return null;
    }
  }

  static String? validateMobileNonRequired(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    if (value.length < 10) {
      return S.current.invalid_phone;
    }
    return null;
    // else if (value[0] == "0") {
    //   return "Invalid phone";
    // } else {
    //   return null;
    // }
  }

  static String? validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return S.current.phone_Required;
    }
    if (value.length < 10) {
      return "Invalid phone";
    }
    return null;
  }

  static String? validateDigit(String? value) {
    String pattern = r"^[0-9]*$";
    RegExp regExp = new RegExp(pattern);
    if (value == null || value.isEmpty) {
      return S.current.invoice_required;
    } else if (!regExp.hasMatch(value) ||
        (value.length > 1 && value[0] == "0")) {
      return S.current.invalid_invoice_amount;
    } else {
      return null;
    }
  }

  static String? validateCash(String? value) {
    String pattern =
        r"(?=.*?\d)^\$?(([1-9]\d{0,2}(,\d{3})*)|\d+)?(\.\d{1,2})?$";
    RegExp regExp = RegExp(pattern);
    // if (value.isEmpty) {
    //   return "Invoice amount is Required";
    // }
    if (value == null || !value.isFloat() && value.isNotEmpty) {
      return S.current.invalid_invoice_amount;
    } else {
      return null;
    }
  }

  static String? validDescription(String value) {
    if (value.isEmpty) {
      return S.current.description_required;
    }
    return null;
  }
}
