import '../../../generated/l10n.dart' show S;
import 'package:intl/intl.dart';

extension StringExtension on String {
  static String toTimeAgo(String timestamp) {
    var timestampx = DateFormat("yyyy-MM-dd HH:mm:ssZ", "en").parseUTC(timestamp).toLocal().toString();
    final year = int.parse(timestampx.substring(0, 4));
    final month = int.parse(timestampx.substring(5, 7));
    final day = int.parse(timestampx.substring(8, 10));
    final hour = int.parse(timestampx.substring(11, 13));
    final minute = int.parse(timestampx.substring(14, 16));

    final DateTime videoDate = DateTime(year, month, day, hour, minute);
    final int diffInHours = DateTime.now().difference(videoDate).inHours;

    String timeAgo = '';
    String timeUnit = '';
    int timeValue = 0;

    if (diffInHours < 1) {
      final diffInMinutes = DateTime.now().difference(videoDate).inMinutes;
      timeValue = diffInMinutes;
      timeUnit = S.current.minute;
    } else if (diffInHours < 24) {
      timeValue = diffInHours;
      timeUnit =  S.current.hour;
    } else if (diffInHours >= 24 && diffInHours < 24 * 7) {
      timeValue = (diffInHours / 24).floor();
      timeUnit =  S.current.day;
    } else if (diffInHours >= 24 * 7 && diffInHours < 24 * 30) {
      timeValue = (diffInHours / (24 * 7)).floor();
      timeUnit =  S.current.week;
    } else if (diffInHours >= 24 * 30 && diffInHours < 24 * 12 * 30) {
      timeValue = (diffInHours / (24 * 30)).floor();
      timeUnit =  S.current.month;
    } else {
      timeValue = (diffInHours / (24 * 365)).floor();
      timeUnit =  S.current.year;
    }

    timeAgo = timeValue.toString() + '' + timeUnit;

    return timeAgo ;
  }
}