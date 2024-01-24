import 'dart:convert';


import 'package:orders_app/src/utils/parser/parser.dart';

import '../../../generated/l10n.dart' show S;
import 'base.dart';

/// Helps [PaginationModel] to call function to parse data
typedef ModelParser<T> = T Function(dynamic data);

class NotificationModel extends BaseModel {
  String? title;
  String? body;
  final String timestamp;
  final bool isInternal;
  final bool viewed;
  final dynamic meta;
  NotificationModel({
    required id,
    required this.timestamp,
    required this.isInternal,
    required this.viewed,
    this.title,
    this.body,
    this.meta,
  }) : super(id: id);

  NotificationModel.fromJson(Map<String, dynamic> json)
      : title = parse<String>(json['title']),
        body = parse<String>(json['body']),
        timestamp = json['timestamp'],
        isInternal = json['is_internal'],
        viewed = json['viewed'],
        meta = json['meta'],
        super(id: json['id']);

  NotificationModel.fromNotificationJson(Map<String, dynamic> json)
      : title = parse<String>(json['title']),
        body = parse<String>(json['body']),
        timestamp = json['timestamp'],
        isInternal = json['is_internal'],
        viewed = json['viewed'],
        meta = json['meta'],
        super(id: json['notification_id']);

  bool get isValid => title != null && body != null;

  void parseMeta() {
    try{
      if(isParsable(meta)){
        final metaData = NotificationMeta.fromJson(jsonDecode(meta));
        if (metaData.model == "order") {
          final notification = RouteNotification.fromJson(jsonDecode(metaData.data));
          title = S.current.route_notification_title(notification.name);
          body = S.current.route_notification_body(notification.state);
        }
      }
    }catch(e){
      print(e);
    }
  }

  @override
  String toString() {
    return 'NotificationModel{title: $title, body: $body, timestamp: $timestamp, isInternal: $isInternal, viewed: $viewed, meta: $meta}';
  }

  /// Returns [List] of [NotificationModel] after parse [data] list.
  ///
  /// throws [Exception] if [data] in `null` or its not [Iterator] or [NotificationModel.fromJson] throws [Exception].
  static List<NotificationModel> parseList(dynamic data) {
    final List<NotificationModel> records = [];
    for (final record in data) {
      final newRecord = NotificationModel.fromJson(record);
      if (newRecord.isInternal) newRecord.parseMeta();
      if (newRecord.isValid) records.add(newRecord);
    }
    return records;
  }
}

class NotificationMeta {
  final String model;
  final dynamic data;
  NotificationMeta({
    required this.model,
    required this.data,
  });

  NotificationMeta.fromJson(Map<String, dynamic> json)
      : model = json['model'],
        data = json['data'];


}

class RouteNotification {
  final int id;
  final String name;
  final String state;
  RouteNotification({
    required this.state,
    required this.id,
    required this.name,
  });

  RouteNotification.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        state = json['state'];

  @override
  String toString() {
    return 'RouteNotification{id: $id, name: $name, state: $state}';
  }
}

class RawNotification {
  final String title;
  final String body;
  final String? model;
  dynamic data;
  RawNotification({
    required this.title,
    required this.body,
    this.model,
    this.data,
  });

  RawNotification.fromJson(Map json)
      : title = json["title"],
        body = json["body"],
        model = json["model"],
        data = json["data"];

  bool get hasModel => model != null;
  bool get hasData => data != null;

  Map<String, dynamic>? parseData() {
    try {
      if (data is String) return jsonDecode(data);
    } catch (e) {}
    return null;
  }

  T? dataToModel<T>(ModelParser parser) {
    try {
      if (data is String) {
        final json = jsonDecode(data);
        return parser(json);
      } else {
        return parser(json);
      }
    } catch (e) {}
    return null;
  }
}