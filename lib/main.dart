import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'src/app.dart';
import 'src/bloc/language_bloc.dart';
import 'src/utils/firebase_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final helper = FirebaseHelper();
  await helper.initialize();

  FirebaseMessaging.onBackgroundMessage(
      FirebaseHelper.firebaseMessagingBackgroundHandler);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  final LanguageBloc lang = LanguageBloc();
  await lang.setLocale();
  runApp(DeliveryApp(
    lang: lang,
  ));
}
