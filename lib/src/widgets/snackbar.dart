
import 'package:flutter/material.dart';
import 'package:orders_app/src/widgets/text_styles.dart';

class CustomSnackbar extends StatelessWidget {
  final String body;
  final String title;
  const CustomSnackbar({
    Key? key,
    required this.body,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
        verticalDividerSmall,
        Text(body),
      ],
    );
  }
}