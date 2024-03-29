import 'package:flutter/material.dart';
import 'package:smartsfv/views/screens/login/SplashScreen.dart';
import 'package:stacked_themes/stacked_themes.dart';

Future main() async {
  await ThemeManager.initialise();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      defaultThemeMode: ThemeMode.light,
      //todo: Light Theme
      lightTheme: ThemeData(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        primaryColor: Color.fromRGBO(60, 141, 188, 1),
        accentColor: Color.fromRGBO(242, 242, 242, 1),
        shadowColor: Color.fromRGBO(0, 0, 0, 0.5),
        hintColor: Colors.black,
      ),
      //todo: Dark Theme
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        backgroundColor: Colors.black,
        primaryColor: Color.fromRGBO(10, 110, 142, 1),
        accentColor: Color.fromRGBO(50, 50, 50, 1),
        shadowColor: Color.fromRGBO(255, 255, 255, 0.5),
        hintColor: Colors.white,
      ),
      //themes: themeChanger.getThemes(),
      //todo: Builder of the theme
      builder: (context, regularTheme, darkTheme, themeMode) => MaterialApp(
        title: 'SMART-SFV',
        theme: regularTheme,
        darkTheme: darkTheme,
        themeMode: themeMode,
        //home: HomeView(),
        home: SplashScreen(), // start with Splash screen
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
