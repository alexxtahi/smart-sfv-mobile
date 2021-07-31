import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:smart_sfv_mobile/views/layouts/DashboardScreen.dart';
import 'package:smart_sfv_mobile/views/layouts/DrawerLayout.dart';
import 'package:smart_sfv_mobile/views/layouts/ProfileLayout.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);
  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  ///The controller of sliding up panel
  SlidingUpPanelController panelController = SlidingUpPanelController();
  @override
  Widget build(BuildContext context) {
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
    SystemChrome.setPreferredOrientations([]);
    // Return building scaffold
    return Stack(
      children: [
        //todo: Drawer Screen
        DrawerLayout(),
        //todo: Home Screen
        DashboardScreen(panelController: panelController),
        //todo: Profile Layout
        ProfileLayout(
          username: 'Alexandre TAHI',
          panelController: panelController,
        ),
      ],
    );
  }
}
