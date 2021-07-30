import 'package:flutter/material.dart';

class MyOutlinedIconButton extends StatefulWidget {
  //todo: Properties
  final String title;
  final String icon;
  final double iconSize;
  final double size;
  final double borderRadius;
  final Color borderColor;
  final Color backgroundColor;
  //todo: Constructor
  MyOutlinedIconButton({
    this.title = 'button',
    required this.icon,
    required this.iconSize,
    required this.size,
    required this.borderRadius,
    required this.borderColor,
    this.backgroundColor = Colors.transparent,
  });
  //todo: State
  @override
  MyOutlinedIconButtonState createState() => MyOutlinedIconButtonState();
}

class MyOutlinedIconButtonState extends State<MyOutlinedIconButton> {
  @override
  Widget build(BuildContext context) {
    // Return building outlined button
    return OutlinedButton(
      onPressed: () {
        print(widget.title + " button pressed !");
      },
      child: Image.asset(
        widget.icon,
        width: widget.iconSize,
        height: widget.iconSize,
      ),
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(horizontal: 0, vertical: 0)),
        minimumSize: MaterialStateProperty.all<Size>(Size(20, 20)),
        backgroundColor:
            MaterialStateProperty.all<Color>(widget.backgroundColor),
        fixedSize:
            MaterialStateProperty.all<Size>(Size(widget.size, widget.size)),
        side: MaterialStateProperty.all<BorderSide>(
            BorderSide(color: widget.borderColor)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
        ),
      ),
    );
  }
}
