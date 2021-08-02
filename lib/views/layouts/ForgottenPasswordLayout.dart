import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:smart_sfv/controllers/ScreenController.dart';
import 'package:smart_sfv/controllers/functions.dart' as functions;
import 'package:smart_sfv/views/components/MyTextField.dart';

class ForgottenPasswordLayout extends StatefulWidget {
  final String title;
  final SlidingUpPanelController panelController;
  ForgottenPasswordLayout({
    Key? key,
    required this.title,
    required this.panelController,
  }) : super(key: key);

  @override
  ForgottenPasswordLayoutState createState() => ForgottenPasswordLayoutState();
}

class ForgottenPasswordLayoutState extends State<ForgottenPasswordLayout> {
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
      anchor: 0.4,
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
              SizedBox(height: 10),
              //todo: title
              Text(
                widget.title,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Color.fromRGBO(0, 0, 0, 0.3),
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 10),
              //todo: Email TextField
              MyTextField(
                focusNode: FocusNode(),
                textEditingController: TextEditingController(),
                borderRadius: Radius.circular(10),
                textColor: Colors.black,
                placeholder: 'Votre E-mail pour le lien de récupération',
                placeholderSize: 13,
                placeholderColor: Color.fromRGBO(0, 0, 0, 0.5),
                suffixIcon: 'assets/img/icons/mail.png',
                cursorColor: Colors.black,
                onTap: () {
                  // Expand the panel
                  widget.panelController.expand();
                  //print('Hidding panel'); // ! debug
                },
                onEditingComplete: () {
                  // Hiding keyboard
                  FocusScope.of(context).requestFocus(FocusNode());
                  // Move the panel to anchor position
                  widget.panelController.anchor();
                },
              ),
              SizedBox(height: 10),
              //todo: Send Button
              OutlinedButton(
                onPressed: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  widget.panelController.hide();
                  functions.showMessageToSnackbar(
                      context: context,
                      message: "E-mail envoyé ! vérifiez votre boîte.",
                      duration: 3,
                      icon: Icon(Icons.mail_outlined));
                  print('envoi du mail de récupération');
                },
                child: Text(
                  'Envoyer',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Color.fromRGBO(60, 141, 188, 1),
                    //color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                style: ButtonStyle(
                  /*padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(horizontal: 0, vertical: 0)),*/
                  minimumSize: MaterialStateProperty.all<Size>(Size(20, 20)),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromRGBO(60, 141, 188, 0.15)),
                  fixedSize:
                      MaterialStateProperty.all<Size>(Size(screenSize[0], 50)),
                  side: MaterialStateProperty.all<BorderSide>(
                      BorderSide(color: Color.fromRGBO(60, 141, 188, 1))),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              //todo: Indications
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    children: [
                      Text(
                        'Pour réinitialiser le mot de passe de votre compte saisissez juste votre adresse mail et validez. Un e-mail contenant un message de récupération vous sera envoyé pour choisir un nouveau mot de passe.',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                          //color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Wrap(
                    children: [
                      Text(
                        'Touchez ce panneau ou glissez le vers le bas pour le retirer.',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                          //color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
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
