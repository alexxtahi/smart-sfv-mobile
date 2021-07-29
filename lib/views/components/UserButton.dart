import 'package:flutter/material.dart';

class MyUserButton extends StatefulWidget {
  //todo: Properties
  final String username;
  final double usernameSize;
  final double avatarRadius;
  final double width;
  final double height;
  final double borderRadius;
  final Color borderColor;
  final Color backgroundColor;
  //todo: Constructor
  MyUserButton({
    required this.username,
    required this.usernameSize,
    required this.avatarRadius,
    required this.width,
    required this.height,
    required this.borderRadius,
    required this.borderColor,
    this.backgroundColor = Colors.transparent,
  });
  //todo: State
  @override
  MyUserButtonState createState() => MyUserButtonState();
}

class MyUserButtonState extends State<MyUserButton> {
  @override
  Widget build(BuildContext context) {
    // Return building User button
    return OutlinedButton(
      onPressed: () {
        print("Username: " + widget.username);
      },
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //todo: User image
            CircleAvatar(
              backgroundColor: Color.fromRGBO(60, 141, 188, 1),
              radius: widget.avatarRadius,
            ),
            /*SizedBox(width: 5),
            //todo: User name
            Container(
              width: 90,
              child: Wrap(
                children: [
                  Text(
                    widget.username,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Color.fromRGBO(60, 141, 188, 1),
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),*/
          ],
        ),
      ),
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(horizontal: 0, vertical: 0)),
        minimumSize: MaterialStateProperty.all<Size>(Size(20, 20)),
        backgroundColor:
            MaterialStateProperty.all<Color>(widget.backgroundColor),
        fixedSize: MaterialStateProperty.all<Size>(
          Size(
            widget.width,
            widget.height,
          ),
        ),
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
