import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:smartsfv/api.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/functions.dart' as functions;
import 'package:smartsfv/views/screens/others/LoginView.dart';
import 'package:smartsfv/views/components/MyOutlinedButton.dart';

class ProfileLayout extends StatefulWidget {
  final String username;
  final SlidingUpPanelController panelController;
  ProfileLayout({
    Key? key,
    required this.username,
    required this.panelController,
  }) : super(key: key);

  @override
  ProfileLayoutState createState() => ProfileLayoutState();
}

class ProfileLayoutState extends State<ProfileLayout> {
  @override
  void initState() {
    //todo: Hide panel
    widget.panelController.hide();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    precacheImage(
        AssetImage('assets/img/backgrounds/storage-center.jpg'), context);
    precacheImage(
        AssetImage('assets/img/backgrounds/gestion-stock.jpg'), context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    List<double> screenSize = ScreenController.getScreenSize(context);
    return SlidingUpPanelWidget(
      controlHeight: 50.0,
      anchor: 0.5,
      panelController: widget.panelController,
      child: Container(
        width: screenSize[0],
        //margin: EdgeInsets.symmetric(horizontal: 15.0),
        decoration: ShapeDecoration(
          color: Colors.white,
          shadows: [
            BoxShadow(
              blurRadius: 5.0,
              spreadRadius: 2.0,
              color: const Color(0x11000000),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //todo: Grap
              Container(
                width: 70,
                height: 10,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 0, 0, 0.17),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              SizedBox(height: 20),
              //todo: Avatar
              CircleAvatar(
                radius: 70,
                backgroundColor: Color.fromRGBO(60, 141, 188, 0.3),
                backgroundImage:
                    AssetImage('assets/img/backgrounds/storage-center.jpg'),
              ),
              SizedBox(height: 15),
              //todo: Username
              Text(
                widget.username,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                  //color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 5),
              //todo: Role
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Color.fromRGBO(0, 0, 0, 0.5),
                    fontSize: 16,
                  ),
                  children: [
                    TextSpan(
                      text: 'Rôle',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    TextSpan(text: ": "),
                    TextSpan(text: "Concepteur de l'application"),
                  ],
                ),
              ),
              SizedBox(height: 20),
              //todo: Buttons
              Column(
                children: [
                  MyOutlinedButton(
                    text: 'Modifier ses informations',
                    textColor: Color.fromRGBO(60, 141, 188, 1),
                    width: screenSize[0],
                    height: 50,
                    borderRadius: 10,
                    borderColor: Color.fromRGBO(60, 141, 188, 10),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyOutlinedButton(
                        text: 'Profil',
                        textColor: Color.fromRGBO(60, 141, 188, 1),
                        width: screenSize[0] / 2.27,
                        height: 50,
                        borderRadius: 10,
                        borderColor: Color.fromRGBO(60, 141, 188, 1),
                        backgroundColor: Color.fromRGBO(60, 141, 188, 0.15),
                        onPressed: getUserData,
                      ),
                      MyOutlinedButton(
                        text: 'Deconnexion',
                        textColor: Color.fromRGBO(221, 75, 57, 1),
                        width: screenSize[0] / 2.27,
                        height: 50,
                        borderRadius: 10,
                        borderColor: Color.fromRGBO(221, 75, 57, 1),
                        backgroundColor: Color.fromRGBO(221, 75, 57, 0.15),
                        onPressed: () {
                          functions.openPage(
                            context,
                            LoginView(),
                            mode: 'pushReplacement',
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      onTap: () {
        ///Customize the processing logic
        if (widget.panelController.status == SlidingUpPanelStatus.expanded) {
          widget.panelController.anchor();
        } else if (widget.panelController.status ==
            SlidingUpPanelStatus.anchored) {
          widget.panelController.hide();
        }
      }, //Pass a onTap callback to customize the processing logic when user click control bar.
      onStatusChanged: (dragging) {
        // If the dragging direction is dragging down
        if (dragging.index == 1) {
          FocusScope.of(context).requestFocus(FocusNode());
          widget.panelController.hide();
          //print("zaza"); // ! debug
        }
      },
      //enableOnTap: true, //Enable the onTap callback for control bar.
      dragDown: (details) {
        //widget.panelController.hide();
        print('dragDown');
      },
      dragStart: (details) {
        print('dragStart');
      },
      dragCancel: () {
        print('dragCancel');
      },
      dragUpdate: (details) {
        //print('dragUpdate,${panelController.status==SlidingUpPanelStatus.dragging?'dragging':''}');
      },
      dragEnd: (details) {
        print('dragEnd');
      },
    );
  }

  //todo: get user datas function
  void getUserData() {
    Api api = new Api();
    api.getUserData(context);
    widget.panelController.hide();
    /*if (api.requestSuccess) {
      functions.showMessageToSnackbar(
        context,
        "Récupération des données réussie",
        5,
        Icon(Icons.check),
      );
    } else {
      functions.showMessageToSnackbar(
        context,
        "Echec de récupération des données",
        5,
        Icon(Icons.close),
      );
    }*/
  }
}
