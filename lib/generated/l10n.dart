// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Delivery`
  String get app {
    return Intl.message(
      'Delivery',
      name: 'app',
      desc: '',
      args: [],
    );
  }

  /// `Double click to exist`
  String get double_click_exit {
    return Intl.message(
      'Double click to exist',
      name: 'double_click_exit',
      desc: '',
      args: [],
    );
  }

  /// `Please wait`
  String get please_wait {
    return Intl.message(
      'Please wait',
      name: 'please_wait',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Show Password`
  String get show_password {
    return Intl.message(
      'Show Password',
      name: 'show_password',
      desc: '',
      args: [],
    );
  }

  /// `Hide Password`
  String get hide_password {
    return Intl.message(
      'Hide Password',
      name: 'hide_password',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Help`
  String get help {
    return Intl.message(
      'Help',
      name: 'help',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get unknown {
    return Intl.message(
      'Unknown',
      name: 'unknown',
      desc: '',
      args: [],
    );
  }

  /// `Call`
  String get call {
    return Intl.message(
      'Call',
      name: 'call',
      desc: '',
      args: [],
    );
  }

  /// `View`
  String get view {
    return Intl.message(
      'View',
      name: 'view',
      desc: '',
      args: [],
    );
  }

  /// `General`
  String get general {
    return Intl.message(
      'General',
      name: 'general',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get change_password {
    return Intl.message(
      'Change Password',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  /// `About Application`
  String get about_application {
    return Intl.message(
      'About Application',
      name: 'about_application',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Police`
  String get privacy_police {
    return Intl.message(
      'Privacy Police',
      name: 'privacy_police',
      desc: '',
      args: [],
    );
  }

  /// `Terms of Use`
  String get terms_of_use {
    return Intl.message(
      'Terms of Use',
      name: 'terms_of_use',
      desc: '',
      args: [],
    );
  }

  /// `Sign Out`
  String get sign_out {
    return Intl.message(
      'Sign Out',
      name: 'sign_out',
      desc: '',
      args: [],
    );
  }

  /// `Create Order`
  String get create_order {
    return Intl.message(
      'Create Order',
      name: 'create_order',
      desc: '',
      args: [],
    );
  }

  /// `Receiver Name`
  String get receiver_name {
    return Intl.message(
      'Receiver Name',
      name: 'receiver_name',
      desc: '',
      args: [],
    );
  }

  /// `ex. Mohammed`
  String get ex_mohammed {
    return Intl.message(
      'ex. Mohammed',
      name: 'ex_mohammed',
      desc: '',
      args: [],
    );
  }

  /// `Receiver Address`
  String get receiver_address {
    return Intl.message(
      'Receiver Address',
      name: 'receiver_address',
      desc: '',
      args: [],
    );
  }

  /// `e.g.: khartoum, Bahri, Almzad`
  String get ex_khartoum_bahri {
    return Intl.message(
      'e.g.: khartoum, Bahri, Almzad',
      name: 'ex_khartoum_bahri',
      desc: '',
      args: [],
    );
  }

  /// `Receiver Mobile`
  String get receiver_mobile {
    return Intl.message(
      'Receiver Mobile',
      name: 'receiver_mobile',
      desc: '',
      args: [],
    );
  }

  /// `Mobile without zero`
  String get mobile_without_zero {
    return Intl.message(
      'Mobile without zero',
      name: 'mobile_without_zero',
      desc: '',
      args: [],
    );
  }

  /// `Invoice`
  String get invoice_amount {
    return Intl.message(
      'Invoice',
      name: 'invoice_amount',
      desc: '',
      args: [],
    );
  }

  /// `Package Price`
  String get package_price {
    return Intl.message(
      'Package Price',
      name: 'package_price',
      desc: '',
      args: [],
    );
  }

  /// `ex. 1,000`
  String get ex_1000 {
    return Intl.message(
      'ex. 1,000',
      name: 'ex_1000',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Charge`
  String get deliver_charge {
    return Intl.message(
      'Delivery Charge',
      name: 'deliver_charge',
      desc: '',
      args: [],
    );
  }

  /// `Paid Amount`
  String get paid_amount {
    return Intl.message(
      'Paid Amount',
      name: 'paid_amount',
      desc: '',
      args: [],
    );
  }

  /// `Collection Amount`
  String get collection_amount {
    return Intl.message(
      'Collection Amount',
      name: 'collection_amount',
      desc: '',
      args: [],
    );
  }

  /// `Collected Amount`
  String get collected_amount {
    return Intl.message(
      'Collected Amount',
      name: 'collected_amount',
      desc: '',
      args: [],
    );
  }

  /// `Drop-off Balance`
  String get drop_off_balance {
    return Intl.message(
      'Drop-off Balance',
      name: 'drop_off_balance',
      desc: '',
      args: [],
    );
  }

  /// `Note`
  String get description {
    return Intl.message(
      'Note',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Write your note`
  String get describe_the_item {
    return Intl.message(
      'Write your note',
      name: 'describe_the_item',
      desc: '',
      args: [],
    );
  }

  /// `Order updated successfully`
  String get order_updated_successfully {
    return Intl.message(
      'Order updated successfully',
      name: 'order_updated_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Order created successfully`
  String get order_created_successfully {
    return Intl.message(
      'Order created successfully',
      name: 'order_created_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Save and Confirm`
  String get save_and_confirm {
    return Intl.message(
      'Save and Confirm',
      name: 'save_and_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Update and Confirm`
  String get update_and_confirm {
    return Intl.message(
      'Update and Confirm',
      name: 'update_and_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Password changed successfully`
  String get password_changed_successfully {
    return Intl.message(
      'Password changed successfully',
      name: 'password_changed_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Change`
  String get change {
    return Intl.message(
      'Change',
      name: 'change',
      desc: '',
      args: [],
    );
  }

  /// `Choose language`
  String get choose_language {
    return Intl.message(
      'Choose language',
      name: 'choose_language',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get arabic {
    return Intl.message(
      'Arabic',
      name: 'arabic',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Change Profile`
  String get change_profile {
    return Intl.message(
      'Change Profile',
      name: 'change_profile',
      desc: '',
      args: [],
    );
  }

  /// `Updated Successfully`
  String get updated_successfully {
    return Intl.message(
      'Updated Successfully',
      name: 'updated_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get gallery {
    return Intl.message(
      'Gallery',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  /// `Remove`
  String get remove {
    return Intl.message(
      'Remove',
      name: 'remove',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Orders`
  String get orders {
    return Intl.message(
      'Orders',
      name: 'orders',
      desc: '',
      args: [],
    );
  }

  /// `Customers`
  String get customers {
    return Intl.message(
      'Customers',
      name: 'customers',
      desc: '',
      args: [],
    );
  }

  /// `Customer`
  String get customer {
    return Intl.message(
      'Customer',
      name: 'customer',
      desc: '',
      args: [],
    );
  }

  /// `Version 1.0`
  String get version {
    return Intl.message(
      'Version 1.0',
      name: 'version',
      desc: '',
      args: [],
    );
  }

  /// `Ashgali delivery`
  String get ashgali_delivery {
    return Intl.message(
      'Ashgali delivery',
      name: 'ashgali_delivery',
      desc: '',
      args: [],
    );
  }

  /// `ex. 9100100100`
  String get ex_9100100100 {
    return Intl.message(
      'ex. 9100100100',
      name: 'ex_9100100100',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get new_password {
    return Intl.message(
      'New Password',
      name: 'new_password',
      desc: '',
      args: [],
    );
  }

  /// `Old Password`
  String get old_password {
    return Intl.message(
      'Old Password',
      name: 'old_password',
      desc: '',
      args: [],
    );
  }

  /// `Update Order`
  String get update_order {
    return Intl.message(
      'Update Order',
      name: 'update_order',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Charge {price} SDG`
  String prince_banner(Object price) {
    return Intl.message(
      'Delivery Charge $price SDG',
      name: 'prince_banner',
      desc: '',
      args: [price],
    );
  }

  /// `DISMISS`
  String get dismiss {
    return Intl.message(
      'DISMISS',
      name: 'dismiss',
      desc: '',
      args: [],
    );
  }

  /// `Balance`
  String get balance {
    return Intl.message(
      'Balance',
      name: 'balance',
      desc: '',
      args: [],
    );
  }

  /// `Pick-up`
  String get sender {
    return Intl.message(
      'Pick-up',
      name: 'sender',
      desc: '',
      args: [],
    );
  }

  /// `Drop-off`
  String get receiver {
    return Intl.message(
      'Drop-off',
      name: 'receiver',
      desc: '',
      args: [],
    );
  }

  /// `You don't have any orders yet, please create orders.`
  String get empty_order {
    return Intl.message(
      'You don\'t have any orders yet, please create orders.',
      name: 'empty_order',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message(
      'Retry',
      name: 'retry',
      desc: '',
      args: [],
    );
  }

  /// `Looks like the server is taking to long to respond, this can be caused by either poor connectivity or an error with our servers. Please try again in a while`
  String get timeout_error {
    return Intl.message(
      'Looks like the server is taking to long to respond, this can be caused by either poor connectivity or an error with our servers. Please try again in a while',
      name: 'timeout_error',
      desc: '',
      args: [],
    );
  }

  /// `Looks like you have an unstable network at the moment, please try again when the network stabilizes.`
  String get socket_error {
    return Intl.message(
      'Looks like you have an unstable network at the moment, please try again when the network stabilizes.',
      name: 'socket_error',
      desc: '',
      args: [],
    );
  }

  /// `Account not found or password invalid`
  String get error_401 {
    return Intl.message(
      'Account not found or password invalid',
      name: 'error_401',
      desc: '',
      args: [],
    );
  }

  /// `forbidden`
  String get error_403 {
    return Intl.message(
      'forbidden',
      name: 'error_403',
      desc: '',
      args: [],
    );
  }

  /// `Internal server error, please contact administrator for more details.`
  String get error_500 {
    return Intl.message(
      'Internal server error, please contact administrator for more details.',
      name: 'error_500',
      desc: '',
      args: [],
    );
  }

  /// `Request page not found please contact administrator for more details.`
  String get error_404 {
    return Intl.message(
      'Request page not found please contact administrator for more details.',
      name: 'error_404',
      desc: '',
      args: [],
    );
  }

  /// `Service not available`
  String get error_503 {
    return Intl.message(
      'Service not available',
      name: 'error_503',
      desc: '',
      args: [],
    );
  }

  /// `Looks like you have an unstable network at the moment, please try again when the network stabilizes.`
  String get error_400 {
    return Intl.message(
      'Looks like you have an unstable network at the moment, please try again when the network stabilizes.',
      name: 'error_400',
      desc: '',
      args: [],
    );
  }

  /// `Ops`
  String get ops {
    return Intl.message(
      'Ops',
      name: 'ops',
      desc: '',
      args: [],
    );
  }

  /// `App Server Error, please contact the admin`
  String get error_1000 {
    return Intl.message(
      'App Server Error, please contact the admin',
      name: 'error_1000',
      desc: '',
      args: [],
    );
  }

  /// `Unauthorized`
  String get error_1101 {
    return Intl.message(
      'Unauthorized',
      name: 'error_1101',
      desc: '',
      args: [],
    );
  }

  /// `Not authorized to access`
  String get error_1102 {
    return Intl.message(
      'Not authorized to access',
      name: 'error_1102',
      desc: '',
      args: [],
    );
  }

  /// `Unprocessable Entity`
  String get error_1103 {
    return Intl.message(
      'Unprocessable Entity',
      name: 'error_1103',
      desc: '',
      args: [],
    );
  }

  /// `Authentication Failed`
  String get error_1104 {
    return Intl.message(
      'Authentication Failed',
      name: 'error_1104',
      desc: '',
      args: [],
    );
  }

  /// `Not found`
  String get error_1105 {
    return Intl.message(
      'Not found',
      name: 'error_1105',
      desc: '',
      args: [],
    );
  }

  /// `Authentication Error, User Not found`
  String get error_1106 {
    return Intl.message(
      'Authentication Error, User Not found',
      name: 'error_1106',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Credentials`
  String get error_1107 {
    return Intl.message(
      'Invalid Credentials',
      name: 'error_1107',
      desc: '',
      args: [],
    );
  }

  /// `Login Error`
  String get error_1108 {
    return Intl.message(
      'Login Error',
      name: 'error_1108',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email or password`
  String get error_1109 {
    return Intl.message(
      'Invalid email or password',
      name: 'error_1109',
      desc: '',
      args: [],
    );
  }

  /// `Your account already exists in the app, please try to login.`
  String get error_1110 {
    return Intl.message(
      'Your account already exists in the app, please try to login.',
      name: 'error_1110',
      desc: '',
      args: [],
    );
  }

  /// `Your request is invalid or your request time is over, please try again.`
  String get error_1111 {
    return Intl.message(
      'Your request is invalid or your request time is over, please try again.',
      name: 'error_1111',
      desc: '',
      args: [],
    );
  }

  /// `You are not authorized to access this app`
  String get error_1112 {
    return Intl.message(
      'You are not authorized to access this app',
      name: 'error_1112',
      desc: '',
      args: [],
    );
  }

  /// `Your account is not activated Please verify your email to activate the account`
  String get error_1113 {
    return Intl.message(
      'Your account is not activated Please verify your email to activate the account',
      name: 'error_1113',
      desc: '',
      args: [],
    );
  }

  /// `Invalid image format`
  String get error_1114 {
    return Intl.message(
      'Invalid image format',
      name: 'error_1114',
      desc: '',
      args: [],
    );
  }

  /// `Image is too big`
  String get error_1115 {
    return Intl.message(
      'Image is too big',
      name: 'error_1115',
      desc: '',
      args: [],
    );
  }

  /// `Data not found`
  String get error_1116 {
    return Intl.message(
      'Data not found',
      name: 'error_1116',
      desc: '',
      args: [],
    );
  }

  /// `Please check you internet connection and try again`
  String get check_connection {
    return Intl.message(
      'Please check you internet connection and try again',
      name: 'check_connection',
      desc: '',
      args: [],
    );
  }

  /// `No image selected, please select image and try again.`
  String get not_image_selected {
    return Intl.message(
      'No image selected, please select image and try again.',
      name: 'not_image_selected',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Server response`
  String get invalid_response {
    return Intl.message(
      'Invalid Server response',
      name: 'invalid_response',
      desc: '',
      args: [],
    );
  }

  /// `Ashgali delivery is a mobile application that provide a delivery service in Khartoum by placing your orders, manage and track them. `
  String get about_application_text {
    return Intl.message(
      'Ashgali delivery is a mobile application that provide a delivery service in Khartoum by placing your orders, manage and track them. ',
      name: 'about_application_text',
      desc: '',
      args: [],
    );
  }

  /// `Email invalid`
  String get email_invalid {
    return Intl.message(
      'Email invalid',
      name: 'email_invalid',
      desc: '',
      args: [],
    );
  }

  /// `Your password must be between not be empty`
  String get password_invalid {
    return Intl.message(
      'Your password must be between not be empty',
      name: 'password_invalid',
      desc: '',
      args: [],
    );
  }

  /// `Name invalid`
  String get name_invalid {
    return Intl.message(
      'Name invalid',
      name: 'name_invalid',
      desc: '',
      args: [],
    );
  }

  /// `Digits only`
  String get digits_only {
    return Intl.message(
      'Digits only',
      name: 'digits_only',
      desc: '',
      args: [],
    );
  }

  /// `Phone number must be 10 digits`
  String get phone_digits_10 {
    return Intl.message(
      'Phone number must be 10 digits',
      name: 'phone_digits_10',
      desc: '',
      args: [],
    );
  }

  /// `Invalid phone number`
  String get invalid_phone_number {
    return Intl.message(
      'Invalid phone number',
      name: 'invalid_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Password is Required`
  String get password_required {
    return Intl.message(
      'Password is Required',
      name: 'password_required',
      desc: '',
      args: [],
    );
  }

  /// `Password must minimum one character`
  String get password_must_have_character {
    return Intl.message(
      'Password must minimum one character',
      name: 'password_must_have_character',
      desc: '',
      args: [],
    );
  }

  /// `Email is Required`
  String get email_required {
    return Intl.message(
      'Email is Required',
      name: 'email_required',
      desc: '',
      args: [],
    );
  }

  /// `Username is Required`
  String get username_required {
    return Intl.message(
      'Username is Required',
      name: 'username_required',
      desc: '',
      args: [],
    );
  }

  /// `Name is Required`
  String get name_required {
    return Intl.message(
      'Name is Required',
      name: 'name_required',
      desc: '',
      args: [],
    );
  }

  /// `Address is Required`
  String get address_required {
    return Intl.message(
      'Address is Required',
      name: 'address_required',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Address`
  String get invalid_Address {
    return Intl.message(
      'Invalid Address',
      name: 'invalid_Address',
      desc: '',
      args: [],
    );
  }

  /// `Phone is Required`
  String get phone_Required {
    return Intl.message(
      'Phone is Required',
      name: 'phone_Required',
      desc: '',
      args: [],
    );
  }

  /// `Invalid phone`
  String get invalid_phone {
    return Intl.message(
      'Invalid phone',
      name: 'invalid_phone',
      desc: '',
      args: [],
    );
  }

  /// `Enter phone number without zero please`
  String get phone_with_no_zero {
    return Intl.message(
      'Enter phone number without zero please',
      name: 'phone_with_no_zero',
      desc: '',
      args: [],
    );
  }

  /// `Invoice amount is Required`
  String get invoice_required {
    return Intl.message(
      'Invoice amount is Required',
      name: 'invoice_required',
      desc: '',
      args: [],
    );
  }

  /// `Invalid invoice amount`
  String get invalid_invoice_amount {
    return Intl.message(
      'Invalid invoice amount',
      name: 'invalid_invoice_amount',
      desc: '',
      args: [],
    );
  }

  /// `Note is required`
  String get description_required {
    return Intl.message(
      'Note is required',
      name: 'description_required',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `No Address`
  String get no_address {
    return Intl.message(
      'No Address',
      name: 'no_address',
      desc: '',
      args: [],
    );
  }

  /// `No Cities`
  String get no_cities {
    return Intl.message(
      'No Cities',
      name: 'no_cities',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Set to draft`
  String get set_to_draft {
    return Intl.message(
      'Set to draft',
      name: 'set_to_draft',
      desc: '',
      args: [],
    );
  }

  /// `Update app`
  String get update_app {
    return Intl.message(
      'Update app',
      name: 'update_app',
      desc: '',
      args: [],
    );
  }

  /// `update now`
  String get update_now {
    return Intl.message(
      'update now',
      name: 'update_now',
      desc: '',
      args: [],
    );
  }

  /// `Close app`
  String get close_app {
    return Intl.message(
      'Close app',
      name: 'close_app',
      desc: '',
      args: [],
    );
  }

  /// `New version of this app is available please update your version now`
  String get update_app_message {
    return Intl.message(
      'New version of this app is available please update your version now',
      name: 'update_app_message',
      desc: '',
      args: [],
    );
  }

  /// `Please select an address`
  String get please_select_address {
    return Intl.message(
      'Please select an address',
      name: 'please_select_address',
      desc: '',
      args: [],
    );
  }

  /// `Please select city`
  String get please_select_city {
    return Intl.message(
      'Please select city',
      name: 'please_select_city',
      desc: '',
      args: [],
    );
  }

  /// `Accounting`
  String get accounting {
    return Intl.message(
      'Accounting',
      name: 'accounting',
      desc: '',
      args: [],
    );
  }

  /// `Delivered`
  String get delivered {
    return Intl.message(
      'Delivered',
      name: 'delivered',
      desc: '',
      args: [],
    );
  }

  /// `Archive`
  String get archive {
    return Intl.message(
      'Archive',
      name: 'archive',
      desc: '',
      args: [],
    );
  }

  /// `timeout`
  String get timeout {
    return Intl.message(
      'timeout',
      name: 'timeout',
      desc: '',
      args: [],
    );
  }

  /// `unhandled error`
  String get unhandled_error {
    return Intl.message(
      'unhandled error',
      name: 'unhandled_error',
      desc: '',
      args: [],
    );
  }

  /// `Session expired`
  String get error_479 {
    return Intl.message(
      'Session expired',
      name: 'error_479',
      desc: '',
      args: [],
    );
  }

  /// `{exception}, please try again or contact administrative for more details`
  String unknown_exception(Object exception) {
    return Intl.message(
      '$exception, please try again or contact administrative for more details',
      name: 'unknown_exception',
      desc: '',
      args: [exception],
    );
  }

  /// `Please contact admin for more details.`
  String get contact_admin {
    return Intl.message(
      'Please contact admin for more details.',
      name: 'contact_admin',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Order {name}`
  String route_notification_title(Object name) {
    return Intl.message(
      'Order $name',
      name: 'route_notification_title',
      desc: '',
      args: [name],
    );
  }

  /// `State has been changed to {state}`
  String route_notification_body(Object state) {
    return Intl.message(
      'State has been changed to $state',
      name: 'route_notification_body',
      desc: '',
      args: [state],
    );
  }

  /// `apply`
  String get apply {
    return Intl.message(
      'apply',
      name: 'apply',
      desc: '',
      args: [],
    );
  }

  /// `reset`
  String get reset {
    return Intl.message(
      'reset',
      name: 'reset',
      desc: '',
      args: [],
    );
  }

  /// `filters`
  String get filters {
    return Intl.message(
      'filters',
      name: 'filters',
      desc: '',
      args: [],
    );
  }

  /// `Unable to handle data`
  String get unable_to_handle_data {
    return Intl.message(
      'Unable to handle data',
      name: 'unable_to_handle_data',
      desc: '',
      args: [],
    );
  }

  /// `m`
  String get minute {
    return Intl.message(
      'm',
      name: 'minute',
      desc: '',
      args: [],
    );
  }

  /// `h`
  String get hour {
    return Intl.message(
      'h',
      name: 'hour',
      desc: '',
      args: [],
    );
  }

  /// `d`
  String get day {
    return Intl.message(
      'd',
      name: 'day',
      desc: '',
      args: [],
    );
  }

  /// `w`
  String get week {
    return Intl.message(
      'w',
      name: 'week',
      desc: '',
      args: [],
    );
  }

  /// `mo`
  String get month {
    return Intl.message(
      'mo',
      name: 'month',
      desc: '',
      args: [],
    );
  }

  /// `y`
  String get year {
    return Intl.message(
      'y',
      name: 'year',
      desc: '',
      args: [],
    );
  }

  /// `No notification`
  String get empty_notifications {
    return Intl.message(
      'No notification',
      name: 'empty_notifications',
      desc: '',
      args: [],
    );
  }

  /// `When notification sent to you will appear here.`
  String get empty_notifications_msg {
    return Intl.message(
      'When notification sent to you will appear here.',
      name: 'empty_notifications_msg',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
