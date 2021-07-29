import 'package:flutter/material.dart';

void showMessageToSnackbar(
    var context, String message, int seconds, Icon icon) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.black,
      duration: Duration(seconds: seconds),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            message,
            style: TextStyle(
              fontFamily: 'Montserrat',
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          icon,
        ],
      ),
    ),
  );
}

void openPage(BuildContext context, Widget view) {
  Navigator.push(
    context,
    new MaterialPageRoute(
      builder: (BuildContext context) {
        return view;
      },
    ),
  );
}
