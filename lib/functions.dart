import 'package:flutter/material.dart';
import 'package:smartsfv/views/components/MyComboBox.dart';
import 'package:smartsfv/views/components/MyOutlinedButton.dart';
import 'package:smartsfv/views/components/MyText.dart';
import 'package:smartsfv/views/components/MyTextFormField.dart';

Future<void> showInformationDialog(BuildContext context) async {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  return await showDialog(
    context: context,
    builder: (context) {
      final TextEditingController textEditingController =
          TextEditingController();
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            elevation: 5,
            contentPadding: EdgeInsets.all(20),
            backgroundColor: Colors.white,
            content: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //todo: Icon
                  Image.asset(
                    'assets/img/icons/cashier.png',
                    width: 40,
                    height: 40,
                    fit: BoxFit.contain,
                    color: Color.fromRGBO(60, 141, 188, 1),
                  ),
                  MyText(
                    text: 'Ajouter une nouvelle caisse',
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //todo: Caisse TextFormField
                  MyTextFormField(
                    textEditingController: textEditingController,
                    validator: (value) {
                      return value!.isNotEmpty
                          ? null
                          : 'Saisissez un nom de caisse';
                    },
                    placeholder: 'Libellé de la caisse',
                    textColor: Color.fromRGBO(60, 141, 188, 1),
                    placeholderColor: Color.fromRGBO(60, 141, 188, 1),
                    fillColor: Color.fromRGBO(60, 141, 188, 0.15),
                    borderRadius: Radius.circular(10),
                    focusBorderColor: Colors.transparent,
                    enableBorderColor: Colors.transparent,
                  ),
                  SizedBox(height: 10),
                  //todo: Dépot DropDownButton
                  MyComboBox(
                    initialDropDownValue: 'Sélectionnez un dépôt',
                    initialDropDownList: [
                      'Sélectionnez un dépôt',
                      for (var i = 1; i <= 10; i++) 'Dépôt $i',
                    ],
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              //todo: Cancel button
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: MyText(
                  text: 'Annuler',
                  color: Color.fromRGBO(221, 75, 57, 1),
                  fontWeight: FontWeight.bold,
                ),
              ),
              //todo: Save button
              TextButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    Navigator.of(context).pop();
                    successSnackbar(
                      context: context,
                      message: 'Nouvelle caisse ajouté !',
                    );
                  }
                },
                child: MyText(
                  text: 'Ajouter',
                  color: Color.fromRGBO(60, 141, 188, 1),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        },
      );
    },
  );
}

void successSnackbar({required BuildContext context, required String message}) {
  showMessageToSnackbar(
    context: context,
    message: message,
    duration: 5,
    icon: Icon(
      Icons.check_rounded,
      color: Colors.white,
    ),
    backgroundColor: Colors.green,
  );
}

void errorSnackbar({required BuildContext context, required String message}) {
  showMessageToSnackbar(
    context: context,
    message: message,
    duration: 5,
    icon: Icon(
      Icons.close_rounded,
      color: Colors.white,
    ),
    backgroundColor: Colors.red,
  );
}

void showMessageToSnackbar({
  required BuildContext context,
  required var message,
  int duration = 2,
  Icon icon = const Icon(Icons.info),
  Color? backgroundColor = Colors.black,
  Color? messageColor = Colors.white,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: backgroundColor,
      duration: Duration(seconds: duration),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          (message is String)
              ? Text(
                  message,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: messageColor,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : message,
          icon,
        ],
      ),
    ),
  );
}

void openPage(BuildContext context, Widget view, {String mode = 'push'}) {
  switch (mode) {
    case 'pushReplacement':
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => view),
      );
      break;
    case 'push':
      Navigator.push(
        context,
        MaterialPageRoute(builder: (BuildContext context) => view),
      );
      break;
    default:
  }
}
