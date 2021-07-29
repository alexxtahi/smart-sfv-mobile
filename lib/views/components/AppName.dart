import 'package:flutter/material.dart';

class AppName extends StatefulWidget {
  final Color color;
  final double fontSize;

  AppName({
    Key? key,
    this.color = const Color.fromRGBO(60, 141, 188, 1),
    this.fontSize = 34,
  }) : super(key: key);

  @override
  AppNameState createState() => AppNameState();
}

class AppNameState extends State<AppName> {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontFamily: 'Montserrat',
          color: widget.color,
          fontSize: widget.fontSize,
        ),
        children: [
          TextSpan(text: 'SMART-'),
          TextSpan(
            text: 'SFV',
            style: TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
