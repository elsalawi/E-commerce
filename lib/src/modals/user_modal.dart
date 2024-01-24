import 'package:orders_app/src/utils/storage/storage_helper.dart';
import 'package:orders_app/src/utils/storage/storage_keys.dart';

class UserModel {
  final int id, partnerId, userId;
  final String name;
  final String email;
  final String mobile;
  final String token;
  final String avatar;
  final bool isVerified;

  UserModel(
      {required this.id,
      required this.partnerId,
      required this.name,
      required this.userId,
      required this.email,
      required this.mobile,
      required this.token,
      required this.avatar,
      required this.isVerified});

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"] as String,
        email = json["email"] is bool ? "" : json["email"],
        partnerId = json["partner_id"] as int,
        userId = json["user_id"] as int,
        mobile = hasValue(json["mobile"]) ? json["mobile"] : "",
        token = hasValue(json["token"]) ? json["token"] : "",
        avatar = json["avatar"] is bool ? "" : json["avatar"],
        isVerified = json["is_verified"] == "false" ? false : true;

  static bool hasValue(dynamic value) {
    if (value == null || value is bool) return false;
    return true;
  }


  Future<void> save() async{
    await StorageHelper.set(StorageKeys.userId, "$id");
    await StorageHelper.set(StorageKeys.name, "$name");
    await StorageHelper.set(StorageKeys.email, "$email");
    await StorageHelper.set(StorageKeys.partnerId, "$partnerId");
    await StorageHelper.set(StorageKeys.mobile, "$mobile");
    await StorageHelper.set(StorageKeys.verified, "$isVerified");
    await StorageHelper.set(StorageKeys.avatar, "$avatar");
    await StorageHelper.set(StorageKeys.token, "$token");
    await StorageHelper.set(StorageKeys.auth, "YES");
  }

  Future<bool> clear() async {
    await StorageHelper.clear();
    return true;
  }
}
