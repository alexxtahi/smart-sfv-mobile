import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:smart_sfv_mobile/api.dart';
import 'package:smart_sfv_mobile/views/HomeView.dart';
import 'package:smart_sfv_mobile/views/components/MyTextField.dart';
import 'package:smart_sfv_mobile/controllers/functions.dart' as functions;

class LoginBox extends StatefulWidget {
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
  ///The controller of login & password TextFIeld
  TextEditingController loginFieldController = TextEditingController();
  TextEditingController passwordFieldController = TextEditingController();
  late FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 0),
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
                      textEditingController: this.loginFieldController,
                      focusNode: FocusNode(),
                      onSubmitted: (inputValue) {
                        //FocusScope.of(context).requestFocus(FocusNode());
                        this.focusNode.requestFocus();
                      },
                    ),
                    SizedBox(height: 15),
                    //todo: Password TextField
                    MyTextField(
                      inputType: 'password',
                      placeholder: 'Mot de passe',
                      suffixIcon: 'assets/img/icons/padlock.png',
                      textEditingController: this.passwordFieldController,
                      focusNode: this.focusNode,
                      onSubmitted: (inputValue) {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                    ),
                    SizedBox(height: 15),
                    //todo: Login Button
                    ElevatedButton(
                      onPressed: () {
                        // ? Get the login inputs value
                        String login = this.loginFieldController.text;
                        String password = this.passwordFieldController.text;
                        // ? Verify the user informations
                        Api api = Api();
                        api.verifyLogin(context);
                        // ? Open the home page when the login is correct
                        functions.openPage(
                            context, HomeView(), 'pushReplacement');
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
                        minimumSize:
                            MaterialStateProperty.all<Size>(Size(20, 20)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            widget.loginButtonColor),
                        fixedSize:
                            MaterialStateProperty.all<Size>(Size(350, 50)),
                        side: MaterialStateProperty.all<BorderSide>(
                            BorderSide(color: Colors.transparent)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
            ),
          ),
        ],
      ),
    );
  }
}
