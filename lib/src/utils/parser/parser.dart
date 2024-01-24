/// Returns [data] value if value type is [T] or `null`.
///
/// Parse [data] value if its [double] or [int] and returns it.
/// This function because Odoo returns `false` instead for  'null' for nullable values.
/// This function allows to specify the type of [data] to prevent invalid types.

T? parse<T>(dynamic data) {
  if (data is T) return data;
  if (data is String && T == double) return double.tryParse(data) as T;
  if (data is String && T == int) return int.tryParse(data) as T ?? null;
  return null;
}

/// Returns [data] value if value type is [T] or `null`.
///
/// Parse [data] value if its [double] or [int] and returns it.
/// This function because Odoo returns `false` instead for  'null' for nullable values.
/// This function allows to specify the type of [data] to prevent invalid types.

T tryParse<T>(dynamic data, T value) {
  if (data.runtimeType == T) return data;
  return value;
}

/// Returns `boot` if [data] is not `null` and run type is not `bool`.
///
/// This function because Odoo returns `false` instead for 'null' for nullable values.
/// This function ensure data can contains data
/// Don't use tis function to handle `bool`.
bool isParsable(dynamic data) => data != null && data.runtimeType != bool;

DateTime? parseDate(dynamic) {
  try {
    DateTime.parse(dynamic);
  } catch (e) {}
}
