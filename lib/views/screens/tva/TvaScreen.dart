import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:smartsfv/api.dart';
import 'package:smartsfv/controllers/DrawerLayoutController.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/models/Tva.dart';
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
  TextEditingController tvaController = TextEditingController();
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
                    keyboardType: TextInputType.number,
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
                          : "Veuillez saisir un pourcentage pour la taxe";
                    },
                    onSubmitted: (text) {
                      // dismiss keyboard
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    suffixIcon: MyOutlinedIconButton(
                      onPressed: () async {
                        // dismiss keyboard
                        FocusScope.of(context).requestFocus(FocusNode());
                        // ? Add new tax when validator is ok
                        if (formKey.currentState!.validate()) {
                          // ? sending datas to API
                          Api api = Api();
                          final Map<String, dynamic> postTvaResponse =
                              await api.postTva(
                            context: context,
                            tva: Tva.fromJson({
                              'montant_tva': this
                                  .textEditingController
                                  .text, // get tva  // ! required
                            }),
                          );
                          // ? check the server response
                          if (postTvaResponse['msg'] ==
                              'Enregistrement effectué avec succès.') {
                            // ? In Success case
                            functions.showSuccessDialog(
                              context: context,
                              message: 'Nouvelle taxe ajoutée !',
                            );
                          } else if (postTvaResponse['msg'] ==
                              'Cet enregistrement existe déjà dans la base') {
                            // ? In instance already exist case
                            functions.showWarningDialog(
                              context: context,
                              message: 'Vous avez déjà enregistré cette taxe !',
                            );
                          } else {
                            // ? In Error case
                            functions.showErrorDialog(
                              context: context,
                              message: "Une erreur s'est produite",
                            );
                          }
                          // ? Refresh taxs list
                          setState(() {});
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
                          if (Tva.tva != null) {
                            // ? Show confirm dialog
                            GlobalKey<FormState> formKey =
                                GlobalKey<FormState>();
                            tvaController.text =
                                (Tva.tva!.percent * 100).toString();
                            functions.showFormDialog(
                              context,
                              formKey,
                              headerIcon: 'assets/img/icons/tax.png',
                              title: 'Modification de la taxe',
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
                                          text: 'Pourcentage',
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
                                      keyboardType: TextInputType.number,
                                      textEditingController: tvaController,
                                      validator: (value) {
                                        if (value != null &&
                                            double.parse(value) ==
                                                Tva.tva!.percent)
                                          return "Saisissez une taxe différente";
                                        else if (value!.isEmpty)
                                          return "Saisissez le pourcentage de la taxe";
                                      },
                                      prefixPadding: 10,
                                      prefixIcon: Icon(
                                        Icons.sort_by_alpha,
                                        color: Color.fromRGBO(60, 141, 188, 1),
                                      ),
                                      placeholder: 'Pourcentage',
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
                                  Tva tvaToUpdate = Tva.tva!;
                                  final Map<String, dynamic> updateTvaResponse =
                                      await api.updateTva(
                                    tva: Tva.fromJson({
                                      'id': tvaToUpdate.id,
                                      'montant_tva':
                                          double.parse(tvaController.text),
                                    }),
                                  );
                                  // ? check the server response
                                  if (updateTvaResponse['msg'] ==
                                      'Modification effectuée avec succès.') {
                                    // ? In Success case
                                    Navigator.of(context).pop();
                                    Tva.tva = null;
                                    functions.showSuccessDialog(
                                      context: context,
                                      message: 'Modification réussie !',
                                    );
                                  } else if (updateTvaResponse['msg'] ==
                                      'Cet enregistrement existe déjà dans la base') {
                                    // ? In instance already exist case
                                    Navigator.of(context).pop();
                                    functions.showWarningDialog(
                                      context: context,
                                      message:
                                          'Vous avez déjà enregistré cette taxe !',
                                    );
                                  } else {
                                    // ? In Error case
                                    Navigator.of(context).pop();
                                    functions.showErrorDialog(
                                      context: context,
                                      message: "Une erreur s'est produite",
                                    );
                                  }
                                  // ? Refresh tva list
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
                          if (Tva.tva != null) {
                            // ? Show confirm dialog
                            functions.showConfirmationDialog(
                              context: context,
                              message:
                                  'Voulez-vous vraiment supprimer la taxe : ' +
                                      (Tva.tva!.percent * 100).toString() +
                                      '% ?',
                              onValidate: () async {
                                // ? sending delete request to API
                                Api api = Api();
                                Tva tvaToDelete = Tva.tva!;
                                final Map<String, dynamic> deleteTvaResponse =
                                    await api.deleteTva(
                                  tva: tvaToDelete,
                                );
                                // ? check the server response
                                if (deleteTvaResponse['msg'] ==
                                    'Opération effectuée avec succès.') {
                                  // ? In Success case
                                  Navigator.of(context).pop();
                                  Tva.tva = null;
                                  functions.showSuccessDialog(
                                    context: context,
                                    message: 'La taxe : ' +
                                        (tvaToDelete.percent * 100).toString() +
                                        '% a bien été supprimée !',
                                  );
                                } else {
                                  // ? In Error case
                                  Navigator.of(context).pop();
                                  functions.showErrorDialog(
                                    context: context,
                                    message: "Une erreur s'est produite",
                                  );
                                }
                                // ? Refresh tva list
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
