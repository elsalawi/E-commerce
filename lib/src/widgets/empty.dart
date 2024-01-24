import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orders_app/src/values/colors.dart';

import 'text_styles.dart';

class EmptyWidget extends StatelessWidget {
  final String text;
  const EmptyWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 260,
            width: 200,
            child: ConstrainedBox(
              constraints: const BoxConstraints.expand(),
              child: Image.asset('assets/not-found.png'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DataErrorWidget extends StatelessWidget {
  final String text;
  final String title;
  final Function() retry;
  const DataErrorWidget({
    Key? key,
    required this.text,
    required this.title,
    required this.retry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 260,
                width: 200,
                child: ConstrainedBox(
                  constraints: const BoxConstraints.expand(),
                  child: Image.asset('assets/not-found.png'),
                ),
              ),
              verticalDividerMedium,
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              verticalDividerMedium,
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              verticalDividerMedium,
              ElevatedButton(
                onPressed: retry,
                child: const Text("Retry"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EmptyRetryWidget extends StatelessWidget {
  final String text;
  final String title;
  final Function() retry;
  const EmptyRetryWidget({
    Key? key,
    required this.text,
    required this.title,
    required this.retry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 260,
            width: 200,
            child: ConstrainedBox(
              constraints: const BoxConstraints.expand(),
              child: Image.asset('assets/images/not-found.png'),
            ),
          ),
          verticalDividerMedium,
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Text(
              title,
              style: accentTextStyleMediumDark,
            ),
          ),
          verticalDividerSmall,
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          verticalDividerLarge,
          ElevatedButton(
            onPressed: retry,
            child: const Text("Retry"),
          )
        ],
      ),
    );
  }
}

class DataErrorMessageWidget extends StatelessWidget {
  final String text;
  final Function() onClick;
  const DataErrorMessageWidget({
    Key? key,
    required this.text,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 150,
                  width: 150,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints.expand(),
                    child: Image.asset('assets/accept.png'),
                  ),
                ),
                verticalDividerMedium,
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  child: Text(
                    "Ops",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                verticalDividerSmall,
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  child: Text(
                    "$text",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                verticalDividerXlarge,
                OutlinedButton(
                  child: const Text(
                    "Try again",
                    style: TextStyle(color: accentColor),
                  ),
                  onPressed: onClick,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
