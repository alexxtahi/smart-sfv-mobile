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
  required String message,
  int duration = 2,
  Icon icon = const Icon(Icons.info),
  Color? backgroundColor,
  Color? messageColor,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor:
          (backgroundColor != null) ? backgroundColor : Colors.black,
      duration: Duration(seconds: duration),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            message,
            style: TextStyle(
              fontFamily: 'Montserrat',
              color: (backgroundColor != null) ? messageColor : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          icon,
        ],
      ),
    ),
  );
}

void openPage(BuildContext context, Widget view, String mode) {
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
