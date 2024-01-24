import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Manages access to [FlutterSecureStorage] data.
///
/// Simplify [FlutterSecureStorage] operations.
/// Uses [StorageKeys] to access [FlutterSecureStorage] stored data.
/// For example access to current sessionId `StorageHelper.get(StorageKeys.sessionId)`.
class StorageHelper {
  static FlutterSecureStorage? _prefs;

  static void _getInstance() => _prefs = const FlutterSecureStorage();

  /// Returns [key] values from [_prefs]
  static Future<String?> get(String key) async {
    _getInstance();
    return _prefs?.read(key: key);
  }

  /// Sets [value] to [key] key in [_prefs]
  static Future<void> set(String key, dynamic value) async {
    _getInstance();
    await _prefs?.write(key: key, value: value);
  }

  /// Remove [key] value from [_prefs]
  static Future<void> remove(String key) async {
    _getInstance();
    _prefs?.delete(key: key);
  }

  /// Clear all data in [_prefs]
  ///
  /// Uses when user logout form current session
  static Future<void> clear() async {
    _getInstance();
    await _prefs?.deleteAll();
  }
}