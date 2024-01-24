import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class BlocBase extends ChangeNotifier {
  final _loading = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get loading => _loading.stream.asBroadcastStream();
  void setLoading(bool status) => _loading.sink.add(status);

  final _errorMessage = PublishSubject<String>();
  Stream<String> get errorMessage =>
      _errorMessage.stream.asBroadcastStream();
  void setError(String date) => _errorMessage.sink.add(date);

  @override
  void dispose() {
    _loading.close();
    _errorMessage.close();
    super.dispose();
  }

  void submitError(String message) {
    if (!_errorMessage.isClosed) {
      setError(message);
      setError("CLEAR");
    }
  }
}