import 'package:flutter/material.dart';
import 'package:smartsfv/views/components/MyText.dart';

Future<void> showFormDialog(
  BuildContext context,
  GlobalKey<FormState> formKey, {
  EdgeInsets padding = const EdgeInsets.all(10),
  String headerIcon = 'assets/img/icons/cashier.png',
  Color headerIconColor = const Color.fromRGBO(60, 141, 188, 1),
  String title = 'Ajouter une nouvelle caisse',
  List<Widget> formElements = const [],
  String successMessage = 'Nouvelle caisse ajouté !',
  String confirmBtnText = 'Valider',
  String cancelBtnText = 'Annuler',
  bool hasHeaderIcon = true,
  bool hasHeaderTitle = true,
  bool hasCancelButton = true,
  bool hasSnackbar = true,
  final void Function()? onValidate,
}) async {
  //GlobalKey<FormState> formKey = GlobalKey<FormState>();
  return await showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            scrollable: true,
            elevation: 5,
            contentPadding: padding,
            backgroundColor: Colors.white,
            content: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  (hasHeaderIcon)
                      ?
                      //todo: Icon
                      Image.asset(
                          headerIcon,
                          width: 40,
                          height: 40,
                          fit: BoxFit.contain,
                          color: headerIconColor,
                        )
                      : Container(),
                  (hasHeaderTitle)
                      ?
                      //todo: Title
                      MyText(
                          text: title,
                          fontWeight: FontWeight.bold,
                        )
                      : Container(),
                  (hasHeaderIcon || hasHeaderTitle)
                      ? SizedBox(height: 20)
                      : Container(),
                  // adding list of new form element in the parameters
                  for (var formElement in formElements) formElement,
                ],
              ),
            ),
            actions: <Widget>[
              //todo: Save button
              TextButton(
                onPressed: onValidate,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MyText(
                      text: confirmBtnText,
                      color: Color.fromRGBO(60, 141, 188, 1),
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(width: 5),
                    Icon(
                      Icons.check,
                      color: Color.fromRGBO(60, 141, 188, 1),
                    ),
                  ],
                ),
              ),
              (hasCancelButton)
                  ?
                  //todo: Cancel button
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          MyText(
                            text: cancelBtnText,
                            color: Color.fromRGBO(221, 75, 57, 1),
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(width: 5),
                          Icon(
                            Icons.close,
                            color: Color.fromRGBO(221, 75, 57, 1),
                          ),
                        ],
                      ),
                    )
                  : Container(),
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
  var icon = const Icon(
    Icons.info,
    color: Colors.white,
  ),
  Color backgroundColor = Colors.black,
  Color messageColor = Colors.white,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: backgroundColor,
      duration: Duration(seconds: duration),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          (message is String)
              ? Flexible(
                  child: MyText(
                    text: message,
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
        MaterialPageRoute(builder: (BuildContext context) => view),
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
