import 'package:flutter/material.dart';

import '../../src/values/colors.dart' as colors;

class Loading extends StatelessWidget {
  final bool backgroundTransparent;
  final String message;
  final Stream<bool> status;
  final Widget child;

  const Loading(
      {Key? key,
      required this.status,
      required this.child,
      required this.message,
      this.backgroundTransparent = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: status,
      builder: (context, snapshot) {
        return Stack(
          children: <Widget>[child, _loading(snapshot.data)],
        );
      },
    );
  }

  Widget _loading(bool? loading) {
    return loading == true
        ? Container(
            alignment: Alignment.center,
            color: backgroundTransparent == true
                ? Colors.transparent
                : Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(
                  strokeWidth: 1,
                  backgroundColor: Colors.transparent,
                  valueColor:
                      new AlwaysStoppedAnimation<Color>(colors.primaryColor),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    message,
                  ),
                ),
              ],
            ),
          )
        : Container();
  }
}
