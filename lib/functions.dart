import 'package:flutter/material.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/models/User.dart';
import 'package:smartsfv/views/components/MyText.dart';

Future<void> showFormDialog(
  var context,
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
  bool hasValidationButton = true,
  bool hasCancelButton = true,
  bool hasSnackbar = true,
  final void Function()? onValidate,
  bool barrierDismissible = true,
}) async {
  //GlobalKey<FormState> formKey = GlobalKey<FormState>();
  return await showDialog(
    barrierDismissible: barrierDismissible,
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
                      Flexible(
                          child: MyText(
                            text: title,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.visible,
                          ),
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
              if (hasValidationButton)
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
              if (hasCancelButton)
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
            ],
          );
        },
      );
    },
  );
}

void successSnackbar({required var context, required String message}) {
  showMessageToSnackbar(
    context: context,
    message: message,
    messageColor: Colors.white,
    duration: 5,
    icon: Icon(
      Icons.check_rounded,
      color: Colors.white,
    ),
    backgroundColor: Colors.green,
  );
}

void errorSnackbar({required var context, required String message}) {
  showMessageToSnackbar(
    context: context,
    message: message,
    messageColor: Colors.white,
    duration: 5,
    icon: Icon(
      Icons.close_rounded,
      color: Colors.white,
    ),
    backgroundColor: Colors.red,
  );
}

void socketErrorSnackbar(
    {required var context,
    String message = 'Erreur de réseau, Vérifiez votre connexion internet.'}) {
  showMessageToSnackbar(
    context: context,
    message: message,
    messageColor: Colors.black,
    backgroundColor: Colors.white,
    duration: 5,
    icon: Icon(
      Icons.wifi_off_rounded,
      color: Colors.red,
    ),
  );
}

void showMessageToSnackbar({
  required var context,
  required var message,
  EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
      /*
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      behavior: SnackBarBehavior.floating,
      margin: padding,
      */
      backgroundColor: backgroundColor,
      duration: Duration(seconds: duration),
      content: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
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
        ],
      ),
    ),
  );
}

void openPage(BuildContext context, Widget view, {String mode = 'push'}) {
  String oldView = ScreenController.actualView;
  switch (mode) {
    case 'pushReplacement':
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (var context) => view),
      );
      break;
    case 'push':
      Navigator.push(
        context,
        MaterialPageRoute(builder: (var context) => view),
      );
      break;
    default:
      String newView = ScreenController.actualView;

      print('Old View: $oldView & NewView: $newView');
  }
}

void logout(var context, {Function()? onValidate}) {
  // ? Show logout form
  showFormDialog(
    context,
    GlobalKey<FormState>(),
    barrierDismissible: false,
    headerIcon: 'assets/img/icons/info.png',
    headerIconColor: Colors.red,
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
    //hasHeaderIcon: false,
    hasSnackbar: false,
    hasHeaderTitle: false,
    hasCancelButton: false,
    hasValidationButton: false,
    confirmBtnText: 'Se déconnecter',
    cancelBtnText: 'Annuler',
    formElements: (User.isConnected == true)
        ? [
            Wrap(
              children: [
                MyText(
                  text: 'Voulez-vous vraiment vous déconnecter ?',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //todo: Exit button
                InkWell(
                  onTap: onValidate,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.red,
                    child: Icon(
                      Icons.exit_to_app,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                //todo: Cancel button
                InkWell(
                  onTap: () {
                    // ? Quit logout AlertDialog
                    if (User.isConnected) Navigator.pop(context);
                  },
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.green,
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ]
        : [
            Column(
              children: [
                //todo: Progress bar
                CircularProgressIndicator(
                  color: Color.fromRGBO(60, 141, 188, 1),
                  backgroundColor: Colors.white.withOpacity(0.1),
                  strokeWidth: 5,
                ),
                SizedBox(height: 15),
                //todo: Logout text
                MyText(
                  text: 'Déconnexion en cours...',
                  fontSize: 16,
                ),
              ],
            ),
          ],
    onValidate: onValidate,
  );
}

//todo: Function to normalize phone numbers
String normalizePhoneNumber(String phoneNumber) {
  String normalizedNumber = '(' + phoneNumber.substring(0, 2) + ')';
  normalizedNumber += ' ' + phoneNumber.substring(2, 4);
  normalizedNumber += '-' + phoneNumber.substring(4, 6);
  normalizedNumber += '-' + phoneNumber.substring(6, 8);
  normalizedNumber += '-' + phoneNumber.substring(8, 10);
  print("Normalized number -> " + normalizedNumber);
  return normalizedNumber;
}

//todo: Show success dialog
void showSuccessDialog({
  required var context,
  String message = 'Succès !',
}) async {
  return await showDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (alertContext, setState) {
          return AlertDialog(
            elevation: 5,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 30,
            ),
            backgroundColor: Colors.white,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.green.withOpacity(0.2),
                  child: Icon(
                    Icons.check_rounded,
                    color: Colors.green,
                    size: 30,
                  ),
                ),
                SizedBox(height: 10),
                Flexible(
                  child: MyText(
                    textAlign: TextAlign.center,
                    text: message,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

//todo: Show warning dialog
void showWarningDialog({
  required var context,
  String message = 'Attention !',
}) async {
  return await showDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (alertContext, setState) {
          return AlertDialog(
            elevation: 5,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 30,
            ),
            backgroundColor: Colors.white,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.yellow[800]!.withOpacity(0.2),
                  child: Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.yellow[800],
                    size: 40,
                  ),
                ),
                SizedBox(height: 10),
                Flexible(
                  child: MyText(
                    textAlign: TextAlign.center,
                    text: message,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

//todo: Show error dialog
void showErrorDialog({
  required var context,
  String message = 'Erreur !',
}) async {
  return await showDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (alertContext, setState) {
          return AlertDialog(
            elevation: 5,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 30,
            ),
            backgroundColor: Colors.white,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.red[800]!.withOpacity(0.2),
                  child: Icon(
                    Icons.error_outline_rounded,
                    color: Colors.red[800],
                    size: 40,
                  ),
                ),
                SizedBox(height: 10),
                Flexible(
                  child: MyText(
                    textAlign: TextAlign.center,
                    text: message,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

//todo: Show confirmation dialog
void showConfirmationDialog({
  required var context,
  String message = 'Êtes-vous sûr ?',
  required void Function()? onValidate,
}) async {
  return await showFormDialog(
    context,
    GlobalKey<FormState>(),
    barrierDismissible: true,
    hasHeaderTitle: false,
    hasHeaderIcon: false,
    hasSnackbar: false,
    onValidate: onValidate,
    formElements: [
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.yellow[800]!.withOpacity(0.2),
            child: Icon(
              Icons.question_answer_outlined,
              color: Colors.yellow[800]!,
              size: 40,
            ),
          ),
          SizedBox(height: 10),
          Flexible(
            child: MyText(
              textAlign: TextAlign.center,
              text: message,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    ],
  );
}
