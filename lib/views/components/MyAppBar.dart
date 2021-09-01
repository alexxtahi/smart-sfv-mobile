import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:smartsfv/controllers/DrawerLayoutController.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/views/components/AppName.dart';
import 'package:smartsfv/views/components/MyOutlinedIconButton.dart';
import 'package:smartsfv/views/components/MyText.dart';
import 'package:smartsfv/views/components/UserAvatar.dart';

class MyAppBar extends StatefulWidget {
  final SlidingUpPanelController panelController;
  final ValueChanged<Function> parentSetState;
  final String icon;
  final Color iconColor;
  final String title;
  MyAppBar({
    Key? key,
    required this.panelController,
    required this.parentSetState,
    this.icon = 'assets/img/icons/house.png',
    this.iconColor = Colors.black,
    this.title = '',
  }) : super(key: key);

  @override
  MyAppBarState createState() => MyAppBarState();
}

class MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //todo: Drawer Button or Back Button
          if (DrawerLayoutController.isDrawerOpen ||
              ScreenController.isChildView)
            // Button when the drawer is open
            MyOutlinedIconButton(
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: Color.fromRGBO(60, 141, 188, 1),
                size: 40,
              ),
              iconSize: 30,
              size: 50,
              borderRadius: 15,
              borderColor: Color.fromRGBO(60, 141, 188, 1),
              backgroundColor: Color.fromRGBO(60, 141, 188, 0.15),
              onPressed: () {
                print("isChildView -> " +
                    ScreenController.isChildView.toString()); // ! debug
                // ? If actual view have drawer
                if (!ScreenController.isChildView)
                  widget.parentSetState(() {
                    DrawerLayoutController.close();
                  });
                // ? Else if actual view haven't drawer
                if (ScreenController.isChildView) {
                  Navigator.of(context).pop();
                  ScreenController.isChildView = false;
                }
              },
            )
          // Button when the drawer is close
          else if (!DrawerLayoutController.isDrawerOpen)
            MyOutlinedIconButton(
              icon: 'assets/img/icons/drawer.png',
              iconSize: 30,
              size: 50,
              borderRadius: 15,
              borderColor: Color.fromRGBO(60, 141, 188, 1),
              backgroundColor: Color.fromRGBO(60, 141, 188, 0.15),
              onPressed: () {
                widget.parentSetState(() {
                  DrawerLayoutController.open(context);
                });
              },
            ),
          //todo: House Icon
          Column(
            children: [
              Image.asset(
                widget.icon,
                width: 40,
                height: 40,
                fit: BoxFit.contain,
                color: widget.iconColor,
              ),
              (widget.title == '')
                  ? AppName(
                      fontSize: 16,
                      color: Color.fromRGBO(193, 193, 193, 1),
                    )
                  : MyText(
                      text: widget.title,
                      fontSize: 14,
                      //color: Color.fromRGBO(60, 141, 188, 1),
                      color: Color.fromRGBO(193, 193, 193, 1),
                      //color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
            ],
          ),
          //todo: User Avatar
          UserAvatar(
            avatarRadius: 25,
            onPressed: () {
              widget.panelController.anchor();
            },
          ),
        ],
      ),
    );
  }
}
