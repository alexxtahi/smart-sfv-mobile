import 'package:flutter/material.dart';

class MyOutlinedIconButton extends StatefulWidget {
  //todo: Properties
  final String title;
  final icon;
  final double iconSize;
  final double size;
  final double borderRadius;
  final Color borderColor;
  final Color backgroundColor;
  final void Function()? onPressed;
  //todo: Constructor
  MyOutlinedIconButton({
    this.title = 'button',
    required this.icon,
    this.size = 50,
    this.iconSize = 25,
    this.borderRadius = 10,
    this.borderColor = Colors.black,
    this.backgroundColor = Colors.transparent,
    this.onPressed,
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
      onPressed: widget.onPressed,
      child: (widget.icon is String)
          ? Image.asset(
              widget.icon,
              width: widget.iconSize,
              height: widget.iconSize,
            )
          : widget.icon,
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
