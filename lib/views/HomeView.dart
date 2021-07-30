import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:smart_sfv_mobile/controllers/ScreenController.dart';
import 'package:smart_sfv_mobile/views/components/AppName.dart';
import 'package:smart_sfv_mobile/views/components/MyOutlinedButton.dart';
import 'package:smart_sfv_mobile/views/components/MyOutlinedIconButton.dart';
import 'package:smart_sfv_mobile/views/components/UserAvatar.dart';
import 'package:smart_sfv_mobile/views/components/UserButton.dart';
import 'package:smart_sfv_mobile/views/layouts/ProfileLayout.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);
  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  ///The controller of sliding up panel
  SlidingUpPanelController panelController = SlidingUpPanelController();
  // textfield controller
  @override
  Widget build(BuildContext context) {
    List<double> screenSize = ScreenController.getScreenSize(context);
    // Change system UI properties
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    // Return building scaffold
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Color.fromRGBO(251, 251, 251, 1),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  //todo: AppBar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //todo: Drawer Button
                      MyOutlinedIconButton(
                        icon: 'assets/img/icons/drawer.png',
                        iconSize: 30,
                        size: 50,
                        borderRadius: 15,
                        borderColor: Color.fromRGBO(60, 141, 188, 1),
                        backgroundColor: Color.fromRGBO(60, 141, 188, 0.15),
                      ),
                      Spacer(),
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
                      Spacer(),
                      //todo: User Avatar
                      UserAvatar(
                        username: 'Alexandre TAHI',
                        avatarRadius: 25,
                        onPressed: () {
                          panelController.anchor();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        ProfileLayout(
          username: 'Alexandre TAHI',
          panelController: panelController,
        ),
      ],
    );
  }
}
