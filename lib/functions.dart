import 'package:flutter/material.dart';
import 'package:smartsfv/views/components/MyTextFormField.dart';

final GlobalKey<FormState> formKey = GlobalKey<FormState>();

Future<void> showInformationDialog(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (context) {
      final TextEditingController textEditingController =
          TextEditingController();
      bool isChecked = false;
      String dropDownValue = 'Sélectionnez un dépôt';
      List<String> depotlist = ['Sélectionnez un dépôt', 'Two', 'Free', 'Four'];
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            content: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //todo: Caisse TextFormField
                    MyTextFormField(
                      textEditingController: textEditingController,
                      validator: (value) {
                        return value!.isNotEmpty ? null : "Invalid Field";
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
                    DropdownButton<String>(
                      isExpanded: true,
                      value: dropDownValue,
                      icon: Icon(Icons.keyboard_arrow_down_rounded),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? newDropDownValue) {
                        setState(() {
                          dropDownValue = newDropDownValue!;
                        });
                      },
                      items: depotlist
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    /*
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Choice Box"),
                        Checkbox(
                            value: isChecked,
                            onChanged: (checked) {
                              setState(() {
                                isChecked = checked!;
                              });
                            })
                      ],
                    ),*/
                  ],
                )),
            actions: <Widget>[
              TextButton(
                child: Text('Okay'),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    // Do something like updating SharedPreferences or User Settings etc.
                    Navigator.of(context).pop();
                  }
                },
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
