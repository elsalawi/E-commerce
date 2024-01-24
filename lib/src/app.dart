import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'bloc/base/bloc_provider.dart';
import 'bloc/language_bloc.dart';
import 'pages/splashscreen_page.dart';
import 'values/theme.dart';
import 'widgets/spinner.dart';
import '../generated/l10n.dart';

class DeliveryApp extends StatelessWidget {
  final LanguageBloc lang;
  const DeliveryApp({
    Key? key,
    required this.lang,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lang: lang,
      child: Consumer<LanguageBloc>(
        child: const Spinner(),
        builder: (_, bloc, __) {
          return MaterialApp(
            theme: appTheme(context),
            home: SplashScreenPage(),
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.light,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            locale: bloc.appLocal,
          );
        },
      ),
    );
  }
}
