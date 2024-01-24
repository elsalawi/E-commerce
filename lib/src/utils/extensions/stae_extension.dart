import 'package:flutter/material.dart';

/// Extends [State] to add more functionality
extension StateMessageExtension on State {
  /// Shows [message] in [SnackBar]
  ///
  /// Clear [SnackBar]s before show [message]
  showMessage(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ));
    }
  }
}
