import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../../../generated/l10n.dart' show S;

class LoadMoreError extends StatelessWidget {
  final Function() onPressed;
  const LoadMoreError({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onPressed,
        behavior: HitTestBehavior.translucent,
        child: Text(S.of(context).retry),
      ),
    );
  }
}
