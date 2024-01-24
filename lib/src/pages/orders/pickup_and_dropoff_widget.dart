import 'package:flutter/material.dart';
import 'package:orders_app/generated/l10n.dart';
import 'package:orders_app/src/values/colors.dart';
import 'package:orders_app/src/widgets/text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class PickupAndDropoffWidget extends StatelessWidget {
//  final OrderModel order;
  final String title;
  final String? name;
  final String? address;
  final String? phone;
  final bool isPickup;

  const PickupAndDropoffWidget({
    Key? key,
    required this.title,
    this.name,
    this.address,
    this.phone,
    this.isPickup = true,
  }) : super(key: key);

  _launchURL(BuildContext context, String? phone) async {
    final url = "tel://$phone}";
    if (phone != null && await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(S.of(context).invalid_phone_number)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          title,
//          S.of(context).receiver,
//          S.of(context).receiver.toUpperCase(),
          style: accentTextStyleMedium,
        ),
        verticalDividerSmall,
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name?.trim() ?? S.of(context).unknown,
                    style: accentTextStyleMediumDarkBold,
                  ),
                  verticalDividerMXSmall,
                  Container(
                    // padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      address ?? S.of(context).unknown,
                      style: accentTextStyleMediumDarkBold,
                    ),
                  ),
                  verticalDividerMXSmall,
                  phone == null
                      ? Container()
                      : Text(phone!, style: accentTextStyleMediumDarkBold),
                ],
              ),
            ),
            SizedBox(width: 2),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => _launchURL(context, phone),
                  child: CircleAvatar(
                    child: const Icon(
                      Icons.call,
                      color: Colors.white,
                      size: 20,
                    ),
                    backgroundColor: isPickup ? accentColor : primaryColor,
                  ),
                )
              ],
            )
          ],
        ),
      ],
    );
  }
}
