import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  const CircleImage({
    Key? key,
    required this.child,
    this.width = 72,
    this.height = 72,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: width,
      width: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(94.0),
        child: FittedBox(
          fit: BoxFit.cover,
          child: child,
        ),
      ),
    );
  }
}

class CircleCachedNetworkAvatar extends StatelessWidget {
  final String url;
  final double size;

  const CircleCachedNetworkAvatar(
      {Key? key, required this.url, this.size = 50.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: size,
        width: size,
        child: url != null
            ? ClipOval(
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/profile.png',
                  image: url,
                  fit: BoxFit.cover,
                ),
              )
            : const CircleAvatar(
                backgroundColor: Colors.greenAccent,
                child: Icon(Icons.person)));
  }
}
