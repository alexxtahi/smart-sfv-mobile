import 'package:flutter/material.dart';

class UserAvatar extends StatefulWidget {
  //todo: Properties
  final String username;
  final double avatarRadius;
  final Color backgroundColor;
  final void Function()? onPressed;
  //todo: Constructor
  UserAvatar({
    required this.username,
    required this.avatarRadius,
    this.backgroundColor = Colors.transparent,
    this.onPressed,
  });
  //todo: State
  @override
  UserAvatarState createState() => UserAvatarState();
}

class UserAvatarState extends State<UserAvatar> {
  @override
  Widget build(BuildContext context) {
    // Return building User button
    return CircleAvatar(
      radius: widget.avatarRadius,
      backgroundImage: AssetImage('assets/img/backgrounds/storage-center.jpg'),
      child: TextButton(
        child: Container(),
        onPressed: widget.onPressed,
        style: ButtonStyle(
          fixedSize: MaterialStateProperty.all<Size>(
            Size(
              50,
              50,
            ),
          ),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(horizontal: 0, vertical: 0)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
    );
  }
}
