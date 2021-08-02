import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:smart_sfv/controllers/DrawerLayoutController.dart';
import 'package:smart_sfv/views/components/MyOutlinedIconButton.dart';
import 'package:smart_sfv/views/components/UserAvatar.dart';

import 'AppName.dart';

class MyAppBar extends StatefulWidget {
  final SlidingUpPanelController panelController;
  final ValueChanged<Function> parentSetState;
  MyAppBar({
    Key? key,
    required this.panelController,
    required this.parentSetState,
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
          //todo: Drawer Button
          (DrawerLayoutController.isDrawerOpen)
              // Button when the drawer is open
              ? MyOutlinedIconButton(
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
                    widget.parentSetState(() {
                      DrawerLayoutController.close();
                    });
                  },
                )
              // Button when the drawer is close
              : MyOutlinedIconButton(
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
                'assets/img/icons/house.png',
                width: 40,
                height: 40,
                fit: BoxFit.contain,
              ),
              AppName(
                fontSize: 16,
                color: Color.fromRGBO(193, 193, 193, 1),
              ),
            ],
          ),
          //todo: User Avatar
          UserAvatar(
            username: 'Alexandre TAHI',
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
