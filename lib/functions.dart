import 'package:flutter/material.dart';

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
