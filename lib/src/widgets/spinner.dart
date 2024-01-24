import 'package:flutter/material.dart';

class Spinner extends StatelessWidget {
  const Spinner();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircularProgressIndicator(strokeWidth: 1),
      ),
    );
  }
}

class SmallSpinner extends StatelessWidget {
  final double width;
  final double height;
  const SmallSpinner({this.width = 24, this.height = 24});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CircularProgressIndicator(
        strokeWidth: 1,
        backgroundColor: Colors.white,
      ),
    );
  }
}

class SliverSpinner extends StatelessWidget {
  const SliverSpinner();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SliverPadding(
      padding: const EdgeInsets.all(8.0),
      sliver: SliverToBoxAdapter(
        child: Container(
          width: size.width,
          height: size.height * 2 / 3,
          child: Center(child: CircularProgressIndicator(strokeWidth: 1)),
        ),
      ),
    );
  }
}
