import 'package:flutter/material.dart';
import 'package:orders_app/src/widgets/text_styles.dart';

class CashItem extends StatelessWidget {
  final String title;
  final String value;
  final bool isLarge;
  const CashItem({
    Key? key,
    required this.title,
    required this.value,
    this.isLarge = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          title,
//          title.toUpperCase(),
          style: isLarge ? accentTextStyleMedium : accentTextStyleSmall,
        ),
        verticalDividerXSmall,
        Text(
          value,
          style: accentTextStyleMediumDarkBold,
        )
      ],
    );
  }
}
