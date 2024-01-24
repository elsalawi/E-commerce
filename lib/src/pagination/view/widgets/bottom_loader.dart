import 'package:flutter/material.dart';


class BottomLoader extends StatelessWidget {
  const BottomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 32, bottom: 24),
        child: Column(
          children: const [
            SizedBox(
              height: 16),
            SizedBox(
              height: 16,
              width: 16,
              child: CircularProgressIndicator(
                strokeWidth: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
