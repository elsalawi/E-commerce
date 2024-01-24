import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:orders_app/src/values/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewExample extends StatefulWidget {
  final customerId;
  const WebViewExample({
    Key? key,
    this.customerId,
  }) : super(key: key);
  @override
  _WebViewExampleState createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    print(
        "$serverUrl/Delivery/orders/customer_accounting?customer_id=${widget.customerId}");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accounting'),
      ),
      body: WebView(
        initialUrl:
            "$serverUrl/Delivery/orders/customer_accounting?customer_id=${widget.customerId}",
        // initialUrl: 'http://23.254.142.150:8040/Delivery/orders/customer_accounting',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
