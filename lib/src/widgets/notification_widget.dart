import 'package:flutter/material.dart';
import 'package:orders_app/src/modals/notification.dart';
import 'package:orders_app/src/utils/extensions/time_ago.dart';
import 'package:orders_app/src/values/colors.dart';

import 'card_view.dart';
import 'text_styles.dart';

class NotificationWidget extends StatelessWidget {
  final NotificationModel model;
  final Function(NotificationModel) onTap;
  const NotificationWidget({
    Key? key,
    required this.model,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => onTap(model),
      child: CardView(
        vrPadding: 12,
        hrPadding: 8,
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CircleAvatar(
              backgroundColor: primaryColor,
              child: Icon(
                Icons.notifications,
                color: Colors.white,
              ),
            ),
            horizontalDividerXMedium,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    model.title!,
                    style: accentTextStyleMediumDarkBold,
                  ),
                  verticalDividerMXSmall,
                  Text(
                    "${model.body}",
                    style: accentTextStyleSmall,
                  ),
                ],
              ),
            ),
            Text(
              StringExtension.toTimeAgo(model.timestamp),
              style: accentTextStyleXSmallBold,
            ),
          ],
        ),
      ),
    );
  }
}
