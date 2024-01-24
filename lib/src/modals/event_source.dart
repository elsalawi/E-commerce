class EventSource<T> {
  final bool loading;
  final bool refresh;
  final String? error;
  final List<T>? data;
  final bool stopLoading;
  final String? meta;
  EventSource({
    required this.loading,
    this.error,
    this.data,
    this.stopLoading = true,
    this.refresh = false,
    this.meta,
  });

  bool get hasError => error?.isNotEmpty ?? false;
  bool get hasData => data != null;
  bool get hasMeta => meta != null;
}

final initEvent = EventSource(
  loading: true,
  data: [],
);
