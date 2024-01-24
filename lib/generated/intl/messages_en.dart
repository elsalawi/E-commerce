// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(price) => "Delivery Charge ${price} SDG";

  static String m1(state) => "State has been changed to ${state}";

  static String m2(name) => "Order ${name}";

  static String m3(exception) =>
      "${exception}, please try again or contact administrative for more details";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("About"),
        "about_application":
            MessageLookupByLibrary.simpleMessage("About Application"),
        "about_application_text": MessageLookupByLibrary.simpleMessage(
            "Ashgali delivery is a mobile application that provide a delivery service in Khartoum by placing your orders, manage and track them. "),
        "account": MessageLookupByLibrary.simpleMessage("Account"),
        "accounting": MessageLookupByLibrary.simpleMessage("Accounting"),
        "address": MessageLookupByLibrary.simpleMessage("Address"),
        "address_required":
            MessageLookupByLibrary.simpleMessage("Address is Required"),
        "app": MessageLookupByLibrary.simpleMessage("Delivery"),
        "apply": MessageLookupByLibrary.simpleMessage("apply"),
        "arabic": MessageLookupByLibrary.simpleMessage("Arabic"),
        "archive": MessageLookupByLibrary.simpleMessage("Archive"),
        "ashgali_delivery":
            MessageLookupByLibrary.simpleMessage("Ashgali delivery"),
        "balance": MessageLookupByLibrary.simpleMessage("Balance"),
        "call": MessageLookupByLibrary.simpleMessage("Call"),
        "camera": MessageLookupByLibrary.simpleMessage("Camera"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "change": MessageLookupByLibrary.simpleMessage("Change"),
        "change_password":
            MessageLookupByLibrary.simpleMessage("Change Password"),
        "change_profile":
            MessageLookupByLibrary.simpleMessage("Change Profile"),
        "check_connection": MessageLookupByLibrary.simpleMessage(
            "Please check you internet connection and try again"),
        "choose_language":
            MessageLookupByLibrary.simpleMessage("Choose language"),
        "city": MessageLookupByLibrary.simpleMessage("City"),
        "close_app": MessageLookupByLibrary.simpleMessage("Close app"),
        "collected_amount":
            MessageLookupByLibrary.simpleMessage("Collected Amount"),
        "collection_amount":
            MessageLookupByLibrary.simpleMessage("Collection Amount"),
        "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
        "contact_admin": MessageLookupByLibrary.simpleMessage(
            "Please contact admin for more details."),
        "create_order": MessageLookupByLibrary.simpleMessage("Create Order"),
        "customer": MessageLookupByLibrary.simpleMessage("Customer"),
        "customers": MessageLookupByLibrary.simpleMessage("Customers"),
        "day": MessageLookupByLibrary.simpleMessage("d"),
        "deliver_charge":
            MessageLookupByLibrary.simpleMessage("Delivery Charge"),
        "delivered": MessageLookupByLibrary.simpleMessage("Delivered"),
        "describe_the_item":
            MessageLookupByLibrary.simpleMessage("Write your note"),
        "description": MessageLookupByLibrary.simpleMessage("Note"),
        "description_required":
            MessageLookupByLibrary.simpleMessage("Note is required"),
        "digits_only": MessageLookupByLibrary.simpleMessage("Digits only"),
        "dismiss": MessageLookupByLibrary.simpleMessage("DISMISS"),
        "double_click_exit":
            MessageLookupByLibrary.simpleMessage("Double click to exist"),
        "drop_off_balance":
            MessageLookupByLibrary.simpleMessage("Drop-off Balance"),
        "email_invalid": MessageLookupByLibrary.simpleMessage("Email invalid"),
        "email_required":
            MessageLookupByLibrary.simpleMessage("Email is Required"),
        "empty_notifications":
            MessageLookupByLibrary.simpleMessage("No notification"),
        "empty_notifications_msg": MessageLookupByLibrary.simpleMessage(
            "When notification sent to you will appear here."),
        "empty_order": MessageLookupByLibrary.simpleMessage(
            "You don\'t have any orders yet, please create orders."),
        "english": MessageLookupByLibrary.simpleMessage("English"),
        "error_1000": MessageLookupByLibrary.simpleMessage(
            "App Server Error, please contact the admin"),
        "error_1101": MessageLookupByLibrary.simpleMessage("Unauthorized"),
        "error_1102":
            MessageLookupByLibrary.simpleMessage("Not authorized to access"),
        "error_1103":
            MessageLookupByLibrary.simpleMessage("Unprocessable Entity"),
        "error_1104":
            MessageLookupByLibrary.simpleMessage("Authentication Failed"),
        "error_1105": MessageLookupByLibrary.simpleMessage("Not found"),
        "error_1106": MessageLookupByLibrary.simpleMessage(
            "Authentication Error, User Not found"),
        "error_1107":
            MessageLookupByLibrary.simpleMessage("Invalid Credentials"),
        "error_1108": MessageLookupByLibrary.simpleMessage("Login Error"),
        "error_1109":
            MessageLookupByLibrary.simpleMessage("Invalid email or password"),
        "error_1110": MessageLookupByLibrary.simpleMessage(
            "Your account already exists in the app, please try to login."),
        "error_1111": MessageLookupByLibrary.simpleMessage(
            "Your request is invalid or your request time is over, please try again."),
        "error_1112": MessageLookupByLibrary.simpleMessage(
            "You are not authorized to access this app"),
        "error_1113": MessageLookupByLibrary.simpleMessage(
            "Your account is not activated Please verify your email to activate the account"),
        "error_1114":
            MessageLookupByLibrary.simpleMessage("Invalid image format"),
        "error_1115": MessageLookupByLibrary.simpleMessage("Image is too big"),
        "error_1116": MessageLookupByLibrary.simpleMessage("Data not found"),
        "error_400": MessageLookupByLibrary.simpleMessage(
            "Looks like you have an unstable network at the moment, please try again when the network stabilizes."),
        "error_401": MessageLookupByLibrary.simpleMessage(
            "Account not found or password invalid"),
        "error_403": MessageLookupByLibrary.simpleMessage("forbidden"),
        "error_404": MessageLookupByLibrary.simpleMessage(
            "Request page not found please contact administrator for more details."),
        "error_479": MessageLookupByLibrary.simpleMessage("Session expired"),
        "error_500": MessageLookupByLibrary.simpleMessage(
            "Internal server error, please contact administrator for more details."),
        "error_503":
            MessageLookupByLibrary.simpleMessage("Service not available"),
        "ex_1000": MessageLookupByLibrary.simpleMessage("ex. 1,000"),
        "ex_9100100100": MessageLookupByLibrary.simpleMessage("ex. 9100100100"),
        "ex_khartoum_bahri": MessageLookupByLibrary.simpleMessage(
            "e.g.: khartoum, Bahri, Almzad"),
        "ex_mohammed": MessageLookupByLibrary.simpleMessage("ex. Mohammed"),
        "filters": MessageLookupByLibrary.simpleMessage("filters"),
        "gallery": MessageLookupByLibrary.simpleMessage("Gallery"),
        "general": MessageLookupByLibrary.simpleMessage("General"),
        "help": MessageLookupByLibrary.simpleMessage("Help"),
        "hide_password": MessageLookupByLibrary.simpleMessage("Hide Password"),
        "hour": MessageLookupByLibrary.simpleMessage("h"),
        "invalid_Address":
            MessageLookupByLibrary.simpleMessage("Invalid Address"),
        "invalid_invoice_amount":
            MessageLookupByLibrary.simpleMessage("Invalid invoice amount"),
        "invalid_phone": MessageLookupByLibrary.simpleMessage("Invalid phone"),
        "invalid_phone_number":
            MessageLookupByLibrary.simpleMessage("Invalid phone number"),
        "invalid_response":
            MessageLookupByLibrary.simpleMessage("Invalid Server response"),
        "invoice_amount": MessageLookupByLibrary.simpleMessage("Invoice"),
        "invoice_required":
            MessageLookupByLibrary.simpleMessage("Invoice amount is Required"),
        "language": MessageLookupByLibrary.simpleMessage("Language"),
        "login": MessageLookupByLibrary.simpleMessage("Login"),
        "minute": MessageLookupByLibrary.simpleMessage("m"),
        "mobile_without_zero":
            MessageLookupByLibrary.simpleMessage("Mobile without zero"),
        "month": MessageLookupByLibrary.simpleMessage("mo"),
        "name": MessageLookupByLibrary.simpleMessage("Name"),
        "name_invalid": MessageLookupByLibrary.simpleMessage("Name invalid"),
        "name_required":
            MessageLookupByLibrary.simpleMessage("Name is Required"),
        "new_password": MessageLookupByLibrary.simpleMessage("New Password"),
        "no_address": MessageLookupByLibrary.simpleMessage("No Address"),
        "no_cities": MessageLookupByLibrary.simpleMessage("No Cities"),
        "not_image_selected": MessageLookupByLibrary.simpleMessage(
            "No image selected, please select image and try again."),
        "notifications": MessageLookupByLibrary.simpleMessage("Notifications"),
        "old_password": MessageLookupByLibrary.simpleMessage("Old Password"),
        "ops": MessageLookupByLibrary.simpleMessage("Ops"),
        "order_created_successfully":
            MessageLookupByLibrary.simpleMessage("Order created successfully"),
        "order_updated_successfully":
            MessageLookupByLibrary.simpleMessage("Order updated successfully"),
        "orders": MessageLookupByLibrary.simpleMessage("Orders"),
        "package_price": MessageLookupByLibrary.simpleMessage("Package Price"),
        "paid_amount": MessageLookupByLibrary.simpleMessage("Paid Amount"),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "password_changed_successfully": MessageLookupByLibrary.simpleMessage(
            "Password changed successfully"),
        "password_invalid": MessageLookupByLibrary.simpleMessage(
            "Your password must be between not be empty"),
        "password_must_have_character": MessageLookupByLibrary.simpleMessage(
            "Password must minimum one character"),
        "password_required":
            MessageLookupByLibrary.simpleMessage("Password is Required"),
        "phone": MessageLookupByLibrary.simpleMessage("Phone"),
        "phone_Required":
            MessageLookupByLibrary.simpleMessage("Phone is Required"),
        "phone_digits_10": MessageLookupByLibrary.simpleMessage(
            "Phone number must be 10 digits"),
        "phone_with_no_zero": MessageLookupByLibrary.simpleMessage(
            "Enter phone number without zero please"),
        "please_select_address":
            MessageLookupByLibrary.simpleMessage("Please select an address"),
        "please_select_city":
            MessageLookupByLibrary.simpleMessage("Please select city"),
        "please_wait": MessageLookupByLibrary.simpleMessage("Please wait"),
        "prince_banner": m0,
        "privacy_police":
            MessageLookupByLibrary.simpleMessage("Privacy Police"),
        "receiver": MessageLookupByLibrary.simpleMessage("Drop-off"),
        "receiver_address":
            MessageLookupByLibrary.simpleMessage("Receiver Address"),
        "receiver_mobile":
            MessageLookupByLibrary.simpleMessage("Receiver Mobile"),
        "receiver_name": MessageLookupByLibrary.simpleMessage("Receiver Name"),
        "remove": MessageLookupByLibrary.simpleMessage("Remove"),
        "reset": MessageLookupByLibrary.simpleMessage("reset"),
        "retry": MessageLookupByLibrary.simpleMessage("Retry"),
        "route_notification_body": m1,
        "route_notification_title": m2,
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "save_and_confirm":
            MessageLookupByLibrary.simpleMessage("Save and Confirm"),
        "sender": MessageLookupByLibrary.simpleMessage("Pick-up"),
        "set_to_draft": MessageLookupByLibrary.simpleMessage("Set to draft"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "show_password": MessageLookupByLibrary.simpleMessage("Show Password"),
        "sign_out": MessageLookupByLibrary.simpleMessage("Sign Out"),
        "socket_error": MessageLookupByLibrary.simpleMessage(
            "Looks like you have an unstable network at the moment, please try again when the network stabilizes."),
        "terms_of_use": MessageLookupByLibrary.simpleMessage("Terms of Use"),
        "timeout": MessageLookupByLibrary.simpleMessage("timeout"),
        "timeout_error": MessageLookupByLibrary.simpleMessage(
            "Looks like the server is taking to long to respond, this can be caused by either poor connectivity or an error with our servers. Please try again in a while"),
        "unable_to_handle_data":
            MessageLookupByLibrary.simpleMessage("Unable to handle data"),
        "unhandled_error":
            MessageLookupByLibrary.simpleMessage("unhandled error"),
        "unknown": MessageLookupByLibrary.simpleMessage("Unknown"),
        "unknown_exception": m3,
        "update": MessageLookupByLibrary.simpleMessage("Update"),
        "update_and_confirm":
            MessageLookupByLibrary.simpleMessage("Update and Confirm"),
        "update_app": MessageLookupByLibrary.simpleMessage("Update app"),
        "update_app_message": MessageLookupByLibrary.simpleMessage(
            "New version of this app is available please update your version now"),
        "update_now": MessageLookupByLibrary.simpleMessage("update now"),
        "update_order": MessageLookupByLibrary.simpleMessage("Update Order"),
        "updated_successfully":
            MessageLookupByLibrary.simpleMessage("Updated Successfully"),
        "username": MessageLookupByLibrary.simpleMessage("Username"),
        "username_required":
            MessageLookupByLibrary.simpleMessage("Username is Required"),
        "version": MessageLookupByLibrary.simpleMessage("Version 1.0"),
        "view": MessageLookupByLibrary.simpleMessage("View"),
        "week": MessageLookupByLibrary.simpleMessage("w"),
        "year": MessageLookupByLibrary.simpleMessage("y")
      };
}
