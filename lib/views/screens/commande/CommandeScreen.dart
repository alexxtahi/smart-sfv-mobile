import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:smartsfv/api.dart';
import 'package:smartsfv/controllers/DrawerLayoutController.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/models/Fournisseur.dart';
import 'package:smartsfv/views/components/MyAppBar.dart';
import 'package:smartsfv/views/components/MyComboBox.dart';
import 'package:smartsfv/views/components/MyOutlinedButton.dart';
import 'package:smartsfv/views/components/MyOutlinedIconButton.dart';
import 'package:smartsfv/views/components/MyText.dart';
import 'package:smartsfv/views/components/MyTextField.dart';
import 'package:smartsfv/functions.dart' as functions;
import 'package:smartsfv/views/screens/commande/CommandeFutureBuilder.dart';

class CommandeScreen extends StatefulWidget {
  final SlidingUpPanelController panelController;
  CommandeScreen({Key? key, required this.panelController}) : super(key: key);
  @override
  CommandeScreenState createState() => CommandeScreenState();
}

class CommandeScreenState extends State<CommandeScreen> {
  ScrollController scrollController = new ScrollController();
  ScrollController datatableScrollController = new ScrollController();
  TextEditingController textEditingController = TextEditingController();
  // init API instance
  Api api = Api();
  String searchBy = 'Par N° de bon';
  String searchByIcon = 'code';
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
                  icon: 'assets/img/icons/shopping-cart.png',
                  iconColor: Color.fromRGBO(0, 27, 121, 1),
                  title: 'Commandes',
                ),
                SizedBox(height: 20),
                //todo: Search Bar
                MyTextField(
                  focusNode: FocusNode(),
                  textEditingController: this.textEditingController,
                  borderRadius: Radius.circular(20),
                  placeholder: 'Rechercher une commande',
                  placeholderColor: Color.fromRGBO(0, 27, 121, 1),
                  cursorColor: Colors.black,
                  textColor: Color.fromRGBO(0, 27, 121, 1),
                  enableBorderColor: Colors.transparent,
                  focusBorderColor: Colors.transparent,
                  fillColor: Color.fromRGBO(60, 141, 188, 0.15),
                  onSubmitted: (text) {
                    // dismiss keyboard
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  suffixIcon: MyOutlinedIconButton(
                    onPressed: () {
                      // dismiss keyboard
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    backgroundColor: Colors.white,
                    borderColor: Colors.transparent,
                    borderRadius: 15,
                    icon: Icon(
                      Icons.search,
                      color: Color.fromRGBO(0, 27, 121, 1),
                      size: 40,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                //todo: Countries & Filters
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: screenSize[0]),
                  child: GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    childAspectRatio: 3,
                    crossAxisSpacing: 10,
                    children: [
                      //todo: Catégories DropDown
                      FutureBuilder<List<Fournisseur>>(
                        future: api.getFournisseurs(context),
                        builder: (comboBoxContext, snapshot) {
                          if (snapshot.hasData) {
                            // ? get nations datas from server
                            return MyComboBox(
                              initialDropDownValue: 'Fournisseurs',
                              initialDropDownList: [
                                'Fournisseurs',
                                // ? datas integration
                                for (var fournisseur in snapshot.data!)
                                  fournisseur.nom!,
                              ],
                              iconSize: 0,
                              textFontSize: 10,
                              prefixPadding: 10,
                              prefixIcon: Image.asset(
                                'assets/img/icons/provider.png',
                                fit: BoxFit.contain,
                                width: 20,
                                height: 20,
                                color: Color.fromRGBO(0, 27, 121, 1),
                              ),
                              textColor: Color.fromRGBO(0, 27, 121, 1),
                              textFontWeight: FontWeight.bold,
                              fillColor: Color.fromRGBO(60, 141, 188, 0.15),
                              borderRadius: Radius.circular(15),
                              focusBorderColor: Colors.transparent,
                              enableBorderColor: Colors.transparent,
                            );
                          } else if (snapshot.hasError) {
                            functions.errorSnackbar(
                              context: context,
                              message: 'Echec de récupération des fournisseurs',
                            );
                            return MyText(
                              text: snapshot.error.toString(),
                              color: Color.fromRGBO(60, 141, 188, 0.5),
                            );
                          }
                          // ? on wait the combo with data load empty combo
                          return MyOutlinedButton(
                            backgroundColor: Color.fromRGBO(60, 141, 188, 0.15),
                            borderRadius: 15,
                            borderColor: Colors.transparent,
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/img/icons/provider.png',
                                  width: 30,
                                  height: 30,
                                  fit: BoxFit.contain,
                                  color: Color.fromRGBO(0, 27, 121, 1),
                                ),
                                SizedBox(width: 15),
                                Flexible(
                                  child: MyText(
                                    text: 'Fournisseurs',
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(0, 27, 121, 1),
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      //todo: Filtres button
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
                            Image.asset(
                              'assets/img/icons/filter1.png',
                              width: 20,
                              height: 20,
                              fit: BoxFit.contain,
                              color: Color.fromRGBO(0, 27, 121, 1),
                            ),
                            SizedBox(width: 15),
                            MyText(
                              text: 'Filtres',
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(0, 27, 121, 1),
                            ),
                          ],
                        ),
                      ),
                      //todo: Search by button
                      MyOutlinedButton(
                        onPressed: () {
                          setState(() {
                            if (this.searchBy == 'Par N° de bon') {
                              this.searchBy = 'Par date';
                              this.searchByIcon = 'calendar';
                            } else {
                              this.searchBy = 'Par N° de bon';
                              this.searchByIcon = 'code';
                            }
                            functions.showMessageToSnackbar(
                              context: context,
                              message: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(text: 'Recherche des commandes '),
                                    TextSpan(
                                      text: this.searchBy.toLowerCase(),
                                      style: TextStyle(
                                        color: Color.fromRGBO(60, 141, 188, 1),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              duration: 5,
                              icon: Icon(
                                Icons.info,
                                color: Color.fromRGBO(60, 141, 188, 1),
                              ),
                            );
                            print('Recherche: ' + this.searchBy);
                          });
                        },
                        backgroundColor: Color.fromRGBO(0, 27, 121, 1),
                        borderRadius: 15,
                        borderColor: Colors.transparent,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/img/icons/$searchByIcon.png',
                              width: 20,
                              height: 20,
                              fit: BoxFit.contain,
                              color: Colors.white,
                            ),
                            SizedBox(width: 15),
                            Flexible(
                              child: MyText(
                                text: this.searchBy,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
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
                          backgroundColor: Color.fromRGBO(0, 27, 121, 1),
                        ),
                        SizedBox(width: 10),
                        MyText(
                          text: 'Liste des commandes',
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color.fromRGBO(0, 27, 121, 1),
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
                            color: Color.fromRGBO(0, 27, 121, 1),
                            strokeWidth: 5,
                          ),
                        );
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.refresh_rounded,
                        color: Color.fromRGBO(0, 27, 121, 1),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                //todo: Scrolling View
                CommandeFutureBuilder(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
