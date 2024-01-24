part of 'pagination_bloc.dart';

@immutable
abstract class PaginationEvent<T> {}

class PaginationLoadEvent<T> extends PaginationEvent<T> {
  final String? filter;
  PaginationLoadEvent({
     this.filter,
  });
}

class PaginationLoadedEvent<T> extends PaginationEvent<T> {
  PaginationLoadedEvent({
    required this.items,
    required this.hasReachedEnd,
    this.filters,
    this.hasError = false,
  });
  final List<T> items;
  final List<String>? filters;
  final bool hasReachedEnd;
  final bool hasError;
}

class PaginationLoadErrorEvent<T> extends PaginationEvent<T> {
  final String error;
  final bool isLoad;
  PaginationLoadErrorEvent({
    required this.error,
    required this.isLoad,
  });
}

class PaginationNewItemAddEvent<T> extends PaginationEvent<T> {
  final T record;
  PaginationNewItemAddEvent({
    required this.record,
  });
}

class PaginationItemUpdatedEvent<T> extends PaginationEvent<T> {
  final T record;
  PaginationItemUpdatedEvent({
    required this.record,
  });
}

class PaginationRefreshEvent<T> extends PaginationEvent<T> {
  final String? filter;
  PaginationRefreshEvent({
    this.filter,
  });
}

class PaginationLoadMoreEvent<T> extends PaginationEvent<T> {
  final String? filter;
  PaginationLoadMoreEvent({
    this.filter,
  });
}

class PaginationRetryEvent<T> extends PaginationEvent<T> {
  final String? filter;
  PaginationRetryEvent({
    this.filter,
  });
}

class PaginationLoadMoreRetryEvent<T> extends PaginationEvent<T> {
  final String? filter;
  PaginationLoadMoreRetryEvent({
    this.filter,
  });
}
