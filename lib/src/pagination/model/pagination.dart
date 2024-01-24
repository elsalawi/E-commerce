
import 'package:orders_app/src/pagination/model/response_model.dart';

/// Helps [PaginationModel] to call function to parse data


/// Hold pagination data
///
/// [total] specify number of records in backend server.
/// [next] specify next records set in pagination.
/// [previous] specify previous records set in pagination.
/// [records] is [List] of records in current page.
class PaginationModel<T> {
  PaginationModel.fromJson(Map data, ModelBuilder<T> builder)
      : total = data['total'],
        next = data['next'],
        previous = data['previous'],
        records = builder(data['records']);
  final int total;
  final String? next;
  final String? previous;
  final List<T> records;

  /// Returns `true` if [next] contains value other wise returns `false`
  bool get hasNext => next != null;

  /// Returns `true` if [previous] contains value other wise returns `false`
  bool get hasPrevious => previous != null;
}