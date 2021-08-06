import 'package:flutter/material.dart';
import 'package:smartsfv/views/components/MyText.dart';

class MyComboBox extends StatefulWidget {
  final String initialDropDownValue;
  final List<String> initialDropDownList;
  final double iconSize;
  final int elevation;
  final Color underlineColor;
  final double underlineThickness;

  MyComboBox({
    Key? key,
    this.initialDropDownValue = 'Sélectionnez...',
    this.initialDropDownList = const ['Sélectionnez...'],
    this.iconSize = 24,
    this.elevation = 16,
    this.underlineColor = const Color.fromRGBO(60, 141, 188, 1),
    this.underlineThickness = 2,
  }) : super(key: key);

  @override
  MyComboBoxState createState() => MyComboBoxState();
}

class MyComboBoxState extends State<MyComboBox> {
  String dropDownValue = '';
  List<String> dropDownList = [];
  @override
  void initState() {
    super.initState();
    this.dropDownValue = widget.initialDropDownValue;
    this.dropDownList = widget.initialDropDownList;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: true,
      value: this.dropDownValue,
      icon: Icon(Icons.keyboard_arrow_down_rounded),
      iconSize: widget.iconSize,
      elevation: widget.elevation,
      style: TextStyle(
        fontFamily: 'Montserrat',
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
        decoration: TextDecoration.none,
      ),
      underline: Container(
        height: widget.underlineThickness,
        color: widget.underlineColor,
      ),
      onChanged: (String? newDropDownValue) {
        setState(() {
          this.dropDownValue = newDropDownValue!;
        });
      },
      items: this.dropDownList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: MyText(text: value),
        );
      }).toList(),
    );
  }
}
