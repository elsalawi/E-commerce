import 'package:flutter/material.dart';
import 'package:orders_app/generated/l10n.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).about),
        leading: BackButton(),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          Image.asset(
            'assets/logo.png',
            height: 56,
            width: 56,
          ),
          const SizedBox(height: 12),
          Text(
            S.of(context).ashgali_delivery,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 8),
          Text(
            S.of(context).version,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 32),
          Text(S.of(context).about_application_text)
        ],
      ),
    );
  }
}
