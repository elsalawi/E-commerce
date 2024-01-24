import 'dart:convert';

import 'order_model.dart';

class PaginationModel {
  final PaginationMetaModel? meta;
  final PaginationLinkModel? links;
  final dynamic data;
  PaginationModel({
    required this.meta,
    required this.links,
    this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'meta': meta?.toMap(),
      'links': links?.toMap(),
    };
  }

  static PaginationModel? fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;
    List data =
        map.containsKey("data") && map["data"].containsKey("delivery_orders")
            ? OrderModel.ordersListFromJson(map["data"]['delivery_orders'])
            : <OrderModel>[];
    final meta = PaginationMetaModel.fromMap(map['meta']);
    final links = PaginationLinkModel.fromMap(map['links']);
    return PaginationModel(meta: meta, links: links, data: data);
  }

  String toJson() => json.encode(toMap());

  static PaginationModel? fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  String toString() =>
      'PaginationModel page: $meta, links: $links, data: $data';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PaginationModel &&
        o.meta == meta &&
        o.links == links &&
        o.data == data;
  }

  bool get hasNext => meta?.hasNext ?? false;
  String? get nextPage => links?.nextPage ;

  @override
  int get hashCode => meta.hashCode ^ links.hashCode ^ data.hashCode;
}

class PaginationPageModel {
  final int? currentPage;
  final int? prePage;
  final int? from;
  final int? to;
  final int total;
  final int lastPage;
  PaginationPageModel(
      {this.currentPage,
      this.prePage,
      this.from,
      this.to,
      required this.total,
      required this.lastPage});
  Map<String, dynamic> toMap() {
    return {
      'currentPage': currentPage,
      'prePage': prePage,
      'from': from,
      'to': to,
      'total': total,
      'lastPage': lastPage,
    };
  }

  bool get isLast => lastPage == 0 || currentPage == lastPage;
  bool get hasNext => currentPage! < lastPage;

  static PaginationPageModel? fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;
    return PaginationPageModel(
      currentPage: map['current-page'] ?? 0,
      prePage: map['pre-page'] ?? 0,
      from: map['from'] ?? 0,
      to: map['to'] ?? 0,
      total: map['total'] ?? 0,
      lastPage: map['last-page'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  static PaginationPageModel? fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  String toString() {
    return 'PaginationPageModel currentPage: $currentPage, prePage: $prePage, from: $from, to: $to, total: $total, lastPage: $lastPage';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PaginationPageModel &&
        o.currentPage == currentPage &&
        o.prePage == prePage &&
        o.from == from &&
        o.to == to &&
        o.total == total &&
        o.lastPage == lastPage;
  }

  @override
  int get hashCode {
    return currentPage.hashCode ^
        prePage.hashCode ^
        from.hashCode ^
        to.hashCode ^
        total.hashCode ^
        lastPage.hashCode;
  }
}

class PaginationMetaModel {
  final PaginationPageModel page;
  PaginationMetaModel({
    required this.page,
  });

  bool get isLast => page.hasNext;

  PaginationMetaModel copyWith({
    PaginationPageModel? page,
  }) {
    return PaginationMetaModel(
      page: page ?? this.page,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'page': page.toMap(),
    };
  }

  static PaginationMetaModel? fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;
    return PaginationMetaModel(
      page: PaginationPageModel.fromMap(map['page'])!,
    );
  }

  String toJson() => json.encode(toMap());

  static PaginationMetaModel? fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  String toString() => 'PaginationMetaModel page: $page';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PaginationMetaModel && o.page == page;
  }

  @override
  int get hashCode => page.hashCode;

  bool get hasNext => page.currentPage! < page.lastPage;
}

class PaginationLinkModel {
  String? first;
  String? prev;
  String? next;
  String? last;
  PaginationLinkModel({
    this.first,
    this.prev,
    this.next,
    this.last,
  });

  PaginationLinkModel copyWith({
    String? first,
    String? prev,
    String? next,
    String? last,
  }) {
    return PaginationLinkModel(
      first: first ?? this.first,
      prev: prev ?? this.prev,
      next: next ?? this.next,
      last: last ?? this.last,
    );
  }

  bool get hasNext => next != null;
  String? get nextPage => next;
  String? get prevPage => prev;
  String? get lastPage => last;
  String? get firstPage => first;

  Map<String, dynamic> toMap() {
    return {
      'first': first,
      'prev': prev,
      'next': next,
      'last': last,
    };
  }

  static PaginationLinkModel? fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;

    return PaginationLinkModel(
      first: map['first'],
      prev: map['prev'],
      next: map['next'],
      last: map['last'],
    );
  }

  String toJson() => json.encode(toMap());

  static PaginationLinkModel? fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  String toString() {
    return 'PaginationLinkModel first: $first, prev: $prev, next: $next, last: $last';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PaginationLinkModel &&
        o.first == first &&
        o.prev == prev &&
        o.next == next &&
        o.last == last;
  }

  @override
  int get hashCode {
    return first.hashCode ^ prev.hashCode ^ next.hashCode ^ last.hashCode;
  }
}
