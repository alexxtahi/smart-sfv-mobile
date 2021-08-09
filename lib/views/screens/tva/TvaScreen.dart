import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:smartsfv/controllers/DrawerLayoutController.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/views/components/MyAppBar.dart';
import 'package:smartsfv/views/components/MyOutlinedButton.dart';
import 'package:smartsfv/views/components/MyOutlinedIconButton.dart';
import 'package:smartsfv/views/components/MyText.dart';
import 'package:smartsfv/functions.dart' as functions;
import 'package:smartsfv/views/components/MyTextFormField.dart';
import 'package:smartsfv/views/screens/tva/TvaFutureBuilder.dart';

class TvaScreen extends StatefulWidget {
  final SlidingUpPanelController panelController;
  TvaScreen({Key? key, required this.panelController}) : super(key: key);
  @override
  TvaScreenState createState() => TvaScreenState();
}

class TvaScreenState extends State<TvaScreen> {
  ScrollController scrollController = ScrollController();
  ScrollController listViewScrollController = ScrollController();
  TextEditingController textEditingController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  //todo: setState function for the childrens
  void setstate(Function childSetState) {
    /*
    * This function is made to set state of this widget by this childrens
    */
    setState(() {
      childSetState();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<double> screenSize = ScreenController.getScreenSize(context);
    // Return building scaffold
    return AnimatedContainer(
      transform: Matrix4.translationValues(
          DrawerLayoutController.xOffset, DrawerLayoutController.yOffset, 0)
        ..scale(DrawerLayoutController.scaleFactor),
      duration: Duration(milliseconds: 250),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(251, 251, 251, 1),
          borderRadius: DrawerLayoutController.borderRadius,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                //todo: AppBar
                MyAppBar(
                  parentSetState: setstate,
                  panelController: widget.panelController,
                  icon: 'assets/img/icons/tax.png',
                  iconColor: Color.fromRGBO(60, 141, 188, 1),
                  title: 'TVA',
                ),
                SizedBox(height: 20),
                //todo: Add tax TextField
                Form(
                  key: formKey,
                  child: MyTextFormField(
                    focusNode: FocusNode(),
                    textEditingController: this.textEditingController,
                    borderRadius: Radius.circular(20),
                    placeholder: 'Ajouter une taxe',
                    textColor: Color.fromRGBO(60, 141, 188, 1),
                    placeholderColor: Color.fromRGBO(60, 141, 188, 1),
                    cursorColor: Colors.black,
                    enableBorderColor: Colors.transparent,
                    focusBorderColor: Colors.transparent,
                    fillColor: Color.fromRGBO(60, 141, 188, 0.15),
                    validator: (value) {
                      return value!.isNotEmpty
                          ? null
                          : "Veuillez saisir un pourcentage";
                    },
                    onSubmitted: (text) {
                      // dismiss keyboard
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    suffixIcon: MyOutlinedIconButton(
                      onPressed: () {
                        // dismiss keyboard
                        FocusScope.of(context).requestFocus(FocusNode());
                        // ? Add new tax when validator is ok
                        if (formKey.currentState!.validate()) {
                          functions.successSnackbar(
                            context: context,
                            message: 'Nouvelle taxe ajoutée !',
                          );
                        } else {
                          functions.errorSnackbar(
                            context: context,
                            message: 'Veuillez saisir un pourcentage',
                          );
                        }
                      },
                      backgroundColor: Colors.white,
                      borderColor: Colors.transparent,
                      borderRadius: 15,
                      icon: Icon(
                        Icons.check,
                        color: Color.fromRGBO(60, 141, 188, 1),
                        size: 40,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                //todo: Edit & Delete buttons
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: screenSize[0]),
                  child: GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    childAspectRatio: 4,
                    crossAxisSpacing: 10,
                    children: [
                      MyOutlinedButton(
                        onPressed: () {},
                        backgroundColor: Color.fromRGBO(60, 141, 188, 0.15),
                        borderRadius: 15,
                        borderColor: Colors.transparent,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.edit_rounded,
                              color: Color.fromRGBO(0, 27, 121, 1),
                            ),
                            SizedBox(width: 15),
                            MyText(
                              text: 'Modifier',
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(0, 27, 121, 1),
                            ),
                          ],
                        ),
                      ),
                      MyOutlinedButton(
                        onPressed: () {},
                        backgroundColor: Color.fromRGBO(221, 75, 57, 0.15),
                        borderRadius: 15,
                        borderColor: Colors.transparent,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.delete_outline_rounded,
                              color: Color.fromRGBO(187, 0, 0, 1),
                            ),
                            SizedBox(width: 15),
                            MyText(
                              text: 'Supprimer',
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(187, 0, 0, 1),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                //todo: List title
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 5,
                          backgroundColor: Color.fromRGBO(60, 141, 188, 1),
                        ),
                        SizedBox(width: 10),
                        MyText(
                          text: 'Liste des taxes',
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color.fromRGBO(60, 141, 188, 1),
                        ),
                      ],
                    ),
                    //todo: Reload button
                    IconButton(
                      splashColor: Color.fromRGBO(60, 141, 188, 0.15),
                      tooltip: 'Actualiser',
                      onPressed: () {
                        // show refresh message
                        functions.showMessageToSnackbar(
                          context: context,
                          message: "Rechargement...",
                          icon: CircularProgressIndicator(
                            color: Color.fromRGBO(60, 141, 188, 1),
                            strokeWidth: 5,
                          ),
                        );
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.refresh_rounded,
                        color: Color.fromRGBO(60, 141, 188, 1),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                //todo: Scrolling View
                TvaFutureBuilder(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
