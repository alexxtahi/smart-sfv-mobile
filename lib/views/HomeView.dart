import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:smart_sfv_mobile/controllers/ScreenController.dart';
import 'package:smart_sfv_mobile/views/components/AppName.dart';
import 'package:smart_sfv_mobile/views/components/DashboardCard.dart';
import 'package:smart_sfv_mobile/views/components/MyOutlinedIconButton.dart';
import 'package:smart_sfv_mobile/views/components/UserAvatar.dart';
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          panelController.anchor();
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  //todo: Dashboard
                  Container(
                    width: screenSize[0],
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      children: [
                        DashboardCard(
                          text: 'Clients',
                          icon: 'assets/img/icons/customer1.png',
                          iconColor: Color.fromRGBO(0, 27, 121, 1),
                        ),
                        DashboardCard(
                          text: 'Articles',
                          icon: 'assets/img/icons/box.png',
                          iconColor: Color.fromRGBO(231, 57, 0, 1),
                          backgroundColor: Color.fromRGBO(243, 156, 18, 1),
                        ),
                        DashboardCard(
                          text: 'Dépôts',
                          icon: 'assets/img/icons/bank.png',
                          iconColor: Color.fromRGBO(0, 77, 0, 1),
                          backgroundColor: Color.fromRGBO(0, 166, 90, 1),
                        ),
                        DashboardCard(
                          text: 'Fournisseurs',
                          icon: 'assets/img/icons/provider.png',
                          iconColor: Color.fromRGBO(187, 0, 0, 1),
                          backgroundColor: Color.fromRGBO(221, 75, 57, 1),
                        ),
                      ],
                    ),
                  )
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
