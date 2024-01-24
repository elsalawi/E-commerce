import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:orders_app/src/modals/user_modal.dart';
import 'package:orders_app/src/repository/auth_repository.dart';
import 'package:orders_app/src/utils/validators.dart';
import 'package:package_info/package_info.dart';

import 'base/bloc_base.dart';

class AuthBloc extends BlocBase with Validators {

  Future<bool> login(String login, String password) async {
    setLoading(true);
    final _service = AuthRepository();
    final resp = await _service.login(login, password);
    if (resp.success) {
      final user = UserModel.fromJson(resp.data);
      await user.save();
      try {
        await FirebaseMessaging.instance
            .subscribeToTopic("ch_${user.partnerId}")
            .timeout(const Duration(seconds: 30));
      } catch (_) {
      }
      setLoading(false);
      return true;
    } else {
      setLoading(false);
      submitError(resp.message);
    }
    return false;
  }

  Future<bool> changePassword(String oldPassword, String newPassword) async {
    setLoading(true);

    final _service = AuthRepository();
    final resp = await _service.changePassword(oldPassword, newPassword);
    setLoading(false);
    if (resp.success) {
      return true;
    } else {
      submitError(resp.message);
    }
    return false;
  }
  Future<bool> checkForUpdates() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String localVersion = packageInfo.version;
    final _service = AuthRepository();
    final resp = await _service.checkForUpdates(localVersion);
    if (resp.success) {
      print("rrp ....");
      print(resp.data['result'].toString().toLowerCase()=="ok");
      return resp.data['result']=="ok"?false:true;
    } else {
      submitError(resp.message);
    }
    return false;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
