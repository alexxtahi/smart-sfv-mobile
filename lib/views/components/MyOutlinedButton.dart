import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyOutlinedButton extends StatefulWidget {
  //todo: Properties
  final String text;
  final Color textColor;
  final double width;
  final double height;
  final double borderRadius;
  final Color borderColor;
  final Color backgroundColor;
  final EdgeInsets padding;
  final void Function()? onPressed;
  var child;
  //todo: Constructor
  MyOutlinedButton({
    this.width = 100,
    this.height = 50,
    this.text = 'button',
    this.textColor = Colors.black,
    this.borderRadius = 15,
    this.borderColor = Colors.black,
    this.onPressed,
    this.backgroundColor = Colors.transparent,
    this.padding = const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
    this.child,
  });
  //todo: State
  @override
  MyOutlinedButtonState createState() => MyOutlinedButtonState();
}

class MyOutlinedButtonState extends State<MyOutlinedButton> {
  @override
  Widget build(BuildContext context) {
    // Return building outlined button
    return OutlinedButton(
      onPressed: widget.onPressed,
      child: (widget.child != null)
          ? widget.child
          : Text(
              widget.text,
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: widget.textColor,
                //color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(widget.padding),
        minimumSize: MaterialStateProperty.all<Size>(Size(20, 20)),
        backgroundColor:
            MaterialStateProperty.all<Color>(widget.backgroundColor),
        fixedSize:
            MaterialStateProperty.all<Size>(Size(widget.width, widget.height)),
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
