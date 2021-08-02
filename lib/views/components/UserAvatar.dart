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
    return InkWell(
      onTap: widget.onPressed,
      child: CircleAvatar(
        radius: widget.avatarRadius,
        backgroundImage:
            AssetImage('assets/img/backgrounds/storage-center.jpg'),
      ),
    );
  }
}
