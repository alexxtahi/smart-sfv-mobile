import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/models/Auth.dart';
import 'package:smartsfv/views/components/MyText.dart';
import 'package:smartsfv/functions.dart' as functions;

class MyDrawerHeader extends StatefulWidget {
  final SlidingUpPanelController panelController;
  MyDrawerHeader({Key? key, required this.panelController}) : super(key: key);

  @override
  MyDrawerHeaderState createState() => MyDrawerHeaderState();
}

class MyDrawerHeaderState extends State<MyDrawerHeader> {
  @override
  Widget build(BuildContext context) {
    List<double> screenSize = ScreenController.getScreenSize(context);
    return InkWell(
      onTap: () {
        widget.panelController.expand();
      },
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: screenSize[0] / 1.25,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                children: [
                  //todo: Profile Picture
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    //backgroundColor: Color.fromRGBO(60, 141, 188, 0.3),
                    child: Icon(
                      Icons.account_circle_outlined,
                      size: 70,
                      color: Color.fromRGBO(60, 141, 188, 1),
                    ),
                    //backgroundImage: AssetImage('assets/img/motion-design/avatar-image.png'),
                  ),
                  SizedBox(width: 10),
                  //todo: Auth.user!name & role
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          text: Auth.user!.name, // ? set user name
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                        MyText(
                          text: Auth.user!.role, // ? set user role
                          color: Colors.white,
                          overflow: TextOverflow.visible,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            //todo: Notification button
            InkWell(
              onTap: () {
                functions.showMessageToSnackbar(
                  context: context,
                  //message: 'Vous avez des messages',
                  message: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(text: "Vous n'avez aucun "),
                        TextSpan(
                          text: 'message',
                          style: TextStyle(color: Colors.yellow[700]),
                        ),
                      ],
                    ),
                  ),
                  icon: Icon(
                    Icons.mail_rounded,
                    color: Colors.yellow[700],
                  ),
                );
              },
              child: Stack(
                children: [
                  //todo: button
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white.withOpacity(0.2),
                    child: Image.asset(
                      'assets/img/icons/mail.png',
                      fit: BoxFit.contain,
                      color: Colors.white,
                      width: 20,
                      height: 20,
                    ),
                  ),
                  //todo: Alert dot
                  (ScreenController.actualView != "LoginView")
                      ? FutureBuilder<List<String>>(
                          future: this.getAlerts(),
                          builder: (alertContext, snapshot) {
                            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                              /*
                        functions.showMessageToSnackbar(
                          context: context,
                          //message: 'Vous avez des messages',
                          message: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(text: 'Vous avez des '),
                                TextSpan(
                                  text: 'messages',
                                  style: TextStyle(color: Colors.yellow),
                                ),
                              ],
                            ),
                          ),
                          icon: Icon(
                            Icons.mail_rounded,
                            color: Colors.yellow,
                          ),
                        );
                        */
                              return Positioned(
                                top: 0,
                                right: 0,
                                child: CircleAvatar(
                                  radius: 5,
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                            return Container();
                          },
                        )
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<String>> getAlerts() async {
    List<String> alerts = <String>[];
    return alerts;
  }
}
