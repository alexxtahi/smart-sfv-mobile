import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:smartsfv/api.dart';
import 'package:smartsfv/controllers/DrawerLayoutController.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/models/Regime.dart';
import 'package:smartsfv/models/Research.dart';
import 'package:smartsfv/views/components/MyAppBar.dart';
import 'package:smartsfv/views/components/MyOutlinedButton.dart';
import 'package:smartsfv/views/components/MyOutlinedIconButton.dart';
import 'package:smartsfv/views/components/MyText.dart';
import 'package:smartsfv/views/components/MyTextField.dart';
import 'package:smartsfv/views/components/MyTextFormField.dart';
import 'package:smartsfv/views/screens/regime/RegimeFutureBuilder.dart';
import 'package:smartsfv/functions.dart' as functions;

class RegimeScreen extends StatefulWidget {
  final SlidingUpPanelController panelController;
  RegimeScreen({Key? key, required this.panelController}) : super(key: key);
  @override
  RegimeScreenState createState() => RegimeScreenState();
}

class RegimeScreenState extends State<RegimeScreen> {
  ScrollController scrollController = ScrollController();
  ScrollController listViewScrollController = ScrollController();
  TextEditingController textEditingController = TextEditingController();
  TextEditingController regimeController = TextEditingController();
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
                  icon: 'assets/img/icons/regim.png',
                  iconColor: Color.fromRGBO(60, 141, 188, 1),
                  title: 'Régime',
                ),
                SizedBox(height: 20),
                //todo: Search Bar
                MyTextField(
                  keyboardType: TextInputType.text,
                  focusNode: FocusNode(),
                  textEditingController: this.textEditingController,
                  borderRadius: Radius.circular(20),
                  placeholder: 'Rechercher un régime',
                  textColor: Color.fromRGBO(60, 141, 188, 1),
                  placeholderColor: Color.fromRGBO(60, 141, 188, 1),
                  cursorColor: Colors.black,
                  enableBorderColor: Colors.transparent,
                  focusBorderColor: Colors.transparent,
                  fillColor: Color.fromRGBO(60, 141, 188, 0.15),
                  onChanged: (text) {
                    // ? Check if the field is empty or not
                    setState(() {
                      if (this.textEditingController.text.isEmpty)
                        Research.reset(); // Reset last research datas
                      else
                        // launch research
                        Research.find(
                          'Regime',
                          this.textEditingController.text,
                        );
                    });
                  },
                  onSubmitted: (text) {
                    // dismiss keyboard
                    FocusScope.of(context).requestFocus(FocusNode());
                    // ? Check if the field is empty or not
                    setState(() {
                      if (this.textEditingController.text.isEmpty)
                        Research.reset(); // Reset last research datas
                      else
                        // launch research
                        Research.find(
                          'Regime',
                          this.textEditingController.text,
                        );
                    });
                  },
                  suffixIcon: MyOutlinedIconButton(
                    onPressed: () {
                      // dismiss keyboard
                      FocusScope.of(context).requestFocus(FocusNode());
                      // ? Check if the field is empty or not
                      setState(() {
                        if (this.textEditingController.text.isEmpty)
                          Research.reset(); // Reset last research datas
                        else
                          // launch research
                          Research.find(
                            'Regime',
                            this.textEditingController.text,
                          );
                      });
                    },
                    backgroundColor: Colors.white,
                    borderColor: Colors.transparent,
                    borderRadius: 15,
                    icon: Icon(
                      Icons.search,
                      color: Color.fromRGBO(60, 141, 188, 1),
                      size: 40,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                //todo: Edit & Delete Button
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: screenSize[0]),
                  child: GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    childAspectRatio: 4,
                    crossAxisSpacing: 10,
                    children: [
                      MyOutlinedButton(
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
                        onPressed: () {
                          if (Regime.regime != null) {
                            // ? Show confirm dialog
                            GlobalKey<FormState> formKey =
                                GlobalKey<FormState>();
                            regimeController.text = Regime.regime!.libelle;
                            functions.showFormDialog(
                              context,
                              formKey,
                              headerIcon: 'assets/img/icons/regim.png',
                              title: 'Modification du régime',
                              formElements: [
                                //todo: Libelle Field
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //todo: Libelle label
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        MyText(
                                          text: 'Libellé',
                                          color: Color.fromRGBO(0, 27, 121, 1),
                                          fontWeight: FontWeight.bold,
                                        ),
                                        CircleAvatar(
                                          radius: 5,
                                          backgroundColor:
                                              Color.fromRGBO(221, 75, 57, 1),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    //todo: Libelle TextFormField
                                    MyTextFormField(
                                      keyboardType: TextInputType.text,
                                      textEditingController: regimeController,
                                      validator: (value) {
                                        if (value != null &&
                                            value == Regime.regime!.libelle)
                                          return "Saisissez un nom différent";
                                        else if (value!.isEmpty)
                                          return "Saisissez le libellé du régime";
                                      },
                                      prefixPadding: 10,
                                      prefixIcon: Icon(
                                        Icons.sort_by_alpha,
                                        color: Color.fromRGBO(60, 141, 188, 1),
                                      ),
                                      placeholder: 'Libellé',
                                      textColor:
                                          Color.fromRGBO(60, 141, 188, 1),
                                      placeholderColor:
                                          Color.fromRGBO(60, 141, 188, 1),
                                      fillColor:
                                          Color.fromRGBO(60, 141, 188, 0.15),
                                      borderRadius: Radius.circular(10),
                                      focusBorderColor: Colors.transparent,
                                      enableBorderColor: Colors.transparent,
                                    ),
                                  ],
                                ),
                              ],
                              onValidate: () async {
                                if (formKey.currentState!.validate()) {
                                  // ? sending update request to API
                                  Api api = Api();
                                  Regime regimeToUpdate = Regime.regime!;
                                  final Map<String, dynamic>
                                      updateRegimeResponse =
                                      await api.updateRegime(
                                    regime: Regime.fromJson({
                                      'id': regimeToUpdate.id,
                                      'libelle_regime': regimeController.text,
                                    }),
                                  );
                                  // ? check the server response
                                  if (updateRegimeResponse['msg'] ==
                                      'Modification effectuée avec succès.') {
                                    // ? In Success case
                                    Navigator.of(context).pop();
                                    Regime.regime = null;
                                    functions.showSuccessDialog(
                                      context: context,
                                      message: 'Modification réussie !',
                                    );
                                  } else if (updateRegimeResponse['msg'] ==
                                      'Cet enregistrement existe déjà dans la base') {
                                    // ? In instance already exist case
                                    Navigator.of(context).pop();
                                    functions.showWarningDialog(
                                      context: context,
                                      message:
                                          'Vous avez déjà enregistré ce régime !',
                                    );
                                  } else {
                                    // ? In Error case
                                    Navigator.of(context).pop();
                                    functions.showErrorDialog(
                                      context: context,
                                      message: "Une erreur s'est produite",
                                    );
                                  }
                                  // ? Refresh regime list
                                  setState(() {});
                                }
                              },
                            );
                          } else {
                            functions.showWarningDialog(
                              context: context,
                              message: "Choisissez d'abord un régime",
                            );
                          }
                        },
                      ),
                      MyOutlinedButton(
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
                        onPressed: () {
                          if (Regime.regime != null) {
                            // ? Show confirm dialog
                            functions.showConfirmationDialog(
                              context: context,
                              message:
                                  'Voulez-vous vraiment supprimer le régime : ' +
                                      Regime.regime!.libelle +
                                      ' ?',
                              onValidate: () async {
                                // ? sending delete request to API
                                Api api = Api();
                                Regime regimeToDelete = Regime.regime!;
                                final Map<String, dynamic>
                                    deleteRegimeResponse =
                                    await api.deleteRegime(
                                  regime: regimeToDelete,
                                );
                                // ? check the server response
                                if (deleteRegimeResponse['msg'] ==
                                    'Opération effectuée avec succès.') {
                                  // ? In Success case
                                  Navigator.of(context).pop();
                                  Regime.regime = null;
                                  functions.showSuccessDialog(
                                    context: context,
                                    message: 'La regime : ' +
                                        regimeToDelete.libelle +
                                        ' a bien été supprimé !',
                                  );
                                } else {
                                  // ? In Error case
                                  Navigator.of(context).pop();
                                  functions.showErrorDialog(
                                    context: context,
                                    message: "Une erreur s'est produite",
                                  );
                                }
                                // ? Refresh regime list
                                setState(() {});
                              },
                            );
                          } else {
                            functions.showWarningDialog(
                              context: context,
                              message: "Choisissez d'abord un régime",
                            );
                          }
                        },
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
                          text: 'Liste des régimes',
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
                RegimeFutureBuilder(),
                //RegimeFutureBuilder(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
