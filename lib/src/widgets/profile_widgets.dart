import 'package:flutter/material.dart';
import 'package:orders_app/generated/l10n.dart';
import 'package:orders_app/src/utils/storage/storage_helper.dart';
import 'package:orders_app/src/utils/storage/storage_keys.dart';
import 'package:orders_app/src/values/colors.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

import 'circular_image.dart';
import 'text_styles.dart';

class ProfileImageWidget extends StatelessWidget {
  final double size;
  const ProfileImageWidget({Key? key, this.size = 42}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "profile",
      child: FutureBuilder<String?>(
        future: StorageHelper.get(StorageKeys.avatar),
        initialData: "User",
        builder: (_, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return FutureBuilder<bool>(
              future: canLaunch(snapshot.data),
              builder: (_, AsyncSnapshot snap) {
                if (snap.hasData && snap.data) {
                  return CircleImage(
                    width: size,
                    height: size,
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: snapshot.data,
                      width: size,
                      height: size,
                    ),
                  );
                } else {
                  return UserImage(
                    size: size,
                  );
                }
              },
            );
          } else {
            return UserImage(
              size: size,
            );
          }
        },
      ),
    );
  }
}

class UserImage extends StatelessWidget {
  final double size;
  const UserImage({Key? key, this.size = 42}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: StorageHelper.get(StorageKeys.name),
      initialData: "User",
      builder: (_, AsyncSnapshot snapshot) {
        final name = snapshot.data;
        return Container(
          width: size,
          height: size,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: primaryColor,
          ),
          child: Text(
            name != null && name.isNotEmpty ? name[0] : "U",
            style: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }
}

class EmailWidget extends StatelessWidget {
  const EmailWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: StorageHelper.get(StorageKeys.email),
      initialData: "",
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data, style: accentTextStyleMediumDarkBold);
        } else {
          return const Text("", style: accentTextStyleMediumDarkBold);
        }
      },
    );
  }
}

class NameWidget extends StatelessWidget {
  const NameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: FutureBuilder<String?>(
        future: StorageHelper.get(StorageKeys.name),
        initialData: "User",
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && snapshot.data != "null" ) {
            return Text(snapshot.data ?? "User", style: accentTextStyleMediumDark);
          } else {
            return Text("User", style: accentTextStyleMediumDark);
          }
        },
      ),
    );
  }
}
class LanguageWidget extends StatelessWidget {
  const LanguageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: StorageHelper.get(StorageKeys.languageCode),
      initialData: "en",
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data == "ar" ? S.of(context).arabic : S.of(context).english, style: accentTextStyleSmallDark);
        } else {
          return Text(S.of(context).english, style: accentTextStyleSmallDark);
        }
      },
    );
  }
}
