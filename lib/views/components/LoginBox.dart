import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:smart_sfv_mobile/views/components/MyTextField.dart';

class LoginBox extends StatefulWidget {
  final double width;
  final double height;
  final Color backgroundColor;
  final double padding;
  final String loginText;
  final Color loginTextColor;
  final String loginButtonText;
  final Color loginButtonTextColor;
  final Color loginButtonColor;
  final String forgottenPasswordText;
  final Color forgottenPasswordTextColor;
  final SlidingUpPanelController panelController = SlidingUpPanelController();

  LoginBox({
    Key? key,
    required this.width,
    required this.height,
    this.backgroundColor = const Color.fromRGBO(255, 255, 255, 0.3),
    this.padding = 20,
    this.loginText = 'Connectez vous',
    this.loginTextColor = Colors.white,
    this.loginButtonText = 'Connexion',
    this.loginButtonTextColor = Colors.white,
    this.loginButtonColor = const Color.fromRGBO(60, 141, 188, 1),
    this.forgottenPasswordText = 'Mot de passe oublié ?',
    this.forgottenPasswordTextColor = Colors.white,
  }) : super(key: key);

  @override
  LoginBoxState createState() => LoginBoxState();
}

class LoginBoxState extends State<LoginBox> {
  ///The controller of sliding up panel
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
      ),
      child: Padding(
        padding: EdgeInsets.all(widget.padding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
              widget.loginText,
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: widget.loginTextColor,
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
                widget.loginButtonText,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: widget.loginButtonTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              style: ButtonStyle(
                elevation: MaterialStateProperty.all<double>(0),
                /*padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(horizontal: 0, vertical: 0)),*/
                minimumSize: MaterialStateProperty.all<Size>(Size(20, 20)),
                backgroundColor:
                    MaterialStateProperty.all<Color>(widget.loginButtonColor),
                fixedSize: MaterialStateProperty.all<Size>(Size(350, 50)),
                side: MaterialStateProperty.all<BorderSide>(
                    BorderSide(color: Colors.transparent)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
              ),
            ),
            //todo: Forgotten Password Button
            TextButton(
              onPressed: () {
                widget.panelController.anchor();
                print('Forgotten password button pressed !');
              },
              child: Text(
                widget.forgottenPasswordText,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: widget.forgottenPasswordTextColor,
                  fontSize: 14,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}