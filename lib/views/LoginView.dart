import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_sfv_mobile/views/components/MyTextField.dart';
import '../controllers/ScreenController.dart';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);
  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  // textfield controller
  @override
  Widget build(BuildContext context) {
    List<double> screenSize = ScreenController.getScreenSize(context);
    // Change system UI properties
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    // Return building scaffold
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            //todo: Background
            Container(
              width: screenSize[0],
              height: screenSize[1],
              decoration: BoxDecoration(
                image: DecorationImage(
                  image:
                      AssetImage('assets/img/backgrounds/storage-center.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  color: Colors.black.withOpacity(0.2),
                ),
              ),
            ),
            //todo: Title
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      fontSize: 34,
                    ),
                    children: [
                      TextSpan(
                        text: 'SMART-',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      TextSpan(
                        text: 'SFV',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                //todo: Login Box
                Container(
                  width: 350,
                  height: 365,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 0.3),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //todo: Key icon
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          child: Image.asset(
                            'assets/img/icons/key.png',
                            width: 30,
                          ),
                        ),
                        //todo: Login text
                        Text(
                          'Connectez vous',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 20),
                        //todo: Login TextField
                        MyTextField(
                          placeholder: 'Login',
                          suffixIcon: 'assets/img/icons/account.png',
                        ),
                        SizedBox(height: 15),
                        //todo: Password TextField
                        MyTextField(
                          placeholder: 'Mot de passe',
                          suffixIcon: 'assets/img/icons/padlock.png',
                        ),
                        SizedBox(height: 15),
                        //todo: Login Button
                        ElevatedButton(
                          onPressed: () {
                            print('Login button pressed !');
                          },
                          child: Text(
                            'Connexion',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all<double>(0),
                            /*padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(horizontal: 0, vertical: 0)),*/
                            minimumSize:
                                MaterialStateProperty.all<Size>(Size(20, 20)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromRGBO(60, 141, 188, 1)),
                            fixedSize:
                                MaterialStateProperty.all<Size>(Size(350, 50)),
                            side: MaterialStateProperty.all<BorderSide>(
                                BorderSide(color: Colors.transparent)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                          ),
                        ),
                        //todo: Forgotten Password Button
                        TextButton(
                          onPressed: () {
                            print('Forgotten password button pressed !');
                          },
                          child: Text(
                            'Mot de passe oublié ?',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                              fontSize: 14,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            //todo: Signature
            Positioned(
              bottom: 10,
              child: Text(
                '© All rights reserved. Group Smarty',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Color.fromRGBO(0, 0, 0, 0.3),
                  //color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
