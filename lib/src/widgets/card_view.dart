
import 'package:flutter/material.dart';

class CardView extends StatelessWidget {
  final Widget child;
  final Alignment? alignment;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? color;
  final EdgeInsets? margin;
  final double? elevation;
  final double? hrPadding;
  final double? vrPadding;
  final double borderRadius;

  const CardView({
    Key? key,
    required this.child,
    this.alignment,
    this.width,
    this.height,
    this.elevation,
    this.margin,
    this.backgroundColor,
    this.hrPadding,
    this.vrPadding,
    this.color,
    this.borderRadius = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: hrPadding ?? 0,
        vertical: vrPadding ?? 0,
      ),
      height: height,
      width: width,
      margin: margin,
      alignment: alignment,
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        border: Border.all(
          color: backgroundColor ?? Colors.white,
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: elevation == null ? 6.0 : elevation!,
          )
        ],
      ),
      child: child,
    );
  }
}