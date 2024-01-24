part of 'pagination_bloc.dart';

@immutable
abstract class PaginationState<T> {}

class PaginationInitial<T> extends PaginationState<T> {}

class PaginationError<T> extends PaginationState<T> {
  final dynamic error;
  PaginationError({
    required this.error,
  });

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PaginationError && o.error == error;
  }

  @override
  int get hashCode => error.hashCode;
}

class PaginationLoadedState<T> extends PaginationState<T> {
  PaginationLoadedState(
      {required this.items,
      required this.hasReachedEnd,
      this.filters,
      this.hasError = false});

  final bool hasReachedEnd;
  final List<T> items;
  final List<String>? filters;
  final bool hasError;

  @override
  int get hashCode => items.hashCode ^ hasReachedEnd.hashCode;

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is PaginationLoadedState<T> &&
        listEquals(o.items, items) &&
        listEquals(o.filters, filters) &&
        o.hasReachedEnd == hasReachedEnd;
  }

  PaginationLoadedState<T> copyWith({
    List<T>? items,
    bool? hasReachedEnd,
    List<String>? filters,
  }) {
    return PaginationLoadedState<T>(
      items: items ?? this.items,
      filters: filters ?? this.filters,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
    );
  }
}

class PaginationRefreshState<T> extends PaginationState<T> {}

class PaginationRetryState<T> extends PaginationState<T> {}

class PaginationLoadMoreRetryState<T> extends PaginationState<T> {}
