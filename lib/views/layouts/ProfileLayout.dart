import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:smart_sfv_mobile/controllers/ScreenController.dart';
import 'package:smart_sfv_mobile/controllers/functions.dart' as functions;
import 'package:smart_sfv_mobile/views/components/MyTextField.dart';

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
  Widget build(BuildContext context) {
    List<double> screenSize = ScreenController.getScreenSize(context);
    return SlidingUpPanelWidget(
      controlHeight: 50.0,
      anchor: 0.6,
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
              Positioned(
                bottom: 10,
                child: Column(
                  children: [
                    OutlinedButton(
                      onPressed: () {},
                      child: Text(
                        'Modifier ses informations',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Color.fromRGBO(60, 141, 188, 1),
                          //color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.symmetric(horizontal: 0, vertical: 0)),
                        minimumSize:
                            MaterialStateProperty.all<Size>(Size(20, 20)),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        fixedSize: MaterialStateProperty.all<Size>(
                            Size(screenSize[0], 50)),
                        side: MaterialStateProperty.all<BorderSide>(
                            BorderSide(color: Color.fromRGBO(60, 141, 188, 1))),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
      enableOnTap: true, //Enable the onTap callback for control bar.
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
}
