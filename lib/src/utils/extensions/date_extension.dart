import 'package:intl/intl.dart';

extension DateTimeFormatExtension on DateTime {
  String parseFormat(String format) {
    final formatter = DateFormat(format);
    return formatter.format(this);
  }

  String fullDate() {
    final formatter = DateFormat('dd MMMM yyyy');
    return formatter.format(this);
  }

  String serverDate() {
    final formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(this);
  }

  String fullTime() {
    final formatter = DateFormat('hh:mm');
    return formatter.format(this);
  }

  String fullDateTime() {
    final formatter = DateFormat('hh:mm dd MMMM yyyy');
    return formatter.format(this);
  }

  String getFullDateTime() {
    final formatter = DateFormat('dd-MM-yyyy hh:mm');
    return formatter.format(this);
  }

  String hhmmddMM() {
    final formatter = DateFormat('hh:mm dd-MM');
    return formatter.format(this);
  }

  String ddMMhhmma() {
    final formatter = DateFormat('dd-MM hh:mm a');
    return formatter.format(this);
  }

  String ddMMyyyyhhmm() {
    final formatter = DateFormat('dd-MM-yyyy hh:mm');
    return formatter.format(this);
  }

  String ddMMyyyyhhmma() {
    return parseFormat('dd/MM/yyyy hh:mm a');
  }

  String dmmyyyy() {
    final formatter = DateFormat('dd MMM yyyy');
    return formatter.format(this);
  }

  String dayDateFormat() {
    final formatter = DateFormat('dd MMM yyyy');
    return formatter.format(this);
  }

  String ctrTime() {
    final formatter = DateFormat('EEEE ,dd MMM yyyy');
    return formatter.format(this);
  }

  String getDay() {
    final formatter = DateFormat('dd');
    return formatter.format(this);
  }

  String getMonth() {
    final formatter = DateFormat('MMMM');
    return formatter.format(this);
  }

  String getYear() {
    final formatter = DateFormat('yyyy');
    return formatter.format(this);
  }

  bool isSameDate(DateTime other) {
    return year == other.year &&
        month == other.month &&
        day == other.day;
  }
}
