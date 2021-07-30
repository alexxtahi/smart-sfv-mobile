import 'package:flutter/material.dart';

class MyText extends StatefulWidget {
  final String text;
  final String fontFamily;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  MyText({
    Key? key,
    required this.text,
    this.fontFamily = 'Montserrat',
    this.color = Colors.black,
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
  }) : super(key: key);
  @override
  MyTextState createState() => MyTextState();
}

class MyTextState extends State<MyText> {
  // Scroll controller
  ScrollController scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: TextStyle(
        fontFamily: widget.fontFamily,
        color: widget.color,
        fontSize: widget.fontSize,
        fontWeight: widget.fontWeight,
      ),
    );
  }
}
