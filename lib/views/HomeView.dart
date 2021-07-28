import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_sfv_mobile/controllers/ThemeController.dart';

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
        //statusBarBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        //statusBarIconBrightness: Brightness.light,
        //systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    // Return building scaffold
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String theme = ThemeController.switchTheme(context);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('appTheme', theme);
          print("Theme has been changed to $theme");
        },
        tooltip: 'Change theme',
        child: Icon(Icons.change_circle),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Column(
          children: <Widget>[],
        ),
      ),
    );
  }
}
