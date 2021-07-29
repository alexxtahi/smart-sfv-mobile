import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_sfv_mobile/views/components/AppName.dart';
import 'package:smart_sfv_mobile/views/components/MyOutlinedButton.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);
  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  // textfield controller
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
    // Return building scaffold
    return Scaffold(
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
                  MyOutlinedButton(
                    icon: 'assets/img/icons/drawer.png',
                    iconSize: 30,
                    size: 50,
                    borderRadius: 15,
                    borderColor: Color.fromRGBO(60, 141, 188, 1),
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
                  //todo: Drawer Button
                  MyOutlinedButton(
                    icon: 'assets/img/icons/drawer.png',
                    iconSize: 30,
                    size: 50,
                    borderRadius: 15,
                    borderColor: Color.fromRGBO(60, 141, 188, 1),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
