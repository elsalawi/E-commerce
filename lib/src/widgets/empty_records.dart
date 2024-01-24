import 'package:flutter/material.dart';
import 'package:orders_app/src/values/colors.dart';
import 'package:orders_app/src/widgets/text_styles.dart';

class EmptyRecordsWidget extends StatelessWidget {
  final String text;
  final String message;
  const EmptyRecordsWidget({
    Key? key,
    required this.text,
    required this.message,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        verticalDividerXXlarge,
        Container(
          height: width / 2,
          width: width - (width / 2),
          padding: EdgeInsets.all(width / 10),
          decoration: BoxDecoration(
            color: primaryColor.withOpacity(.07),
            shape: BoxShape.circle,
          ),
          child: Image.asset("assets/empty.png"),
        ),
        verticalDividerMedium,
        Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        verticalDividerMedium,
        Text(
          message,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}