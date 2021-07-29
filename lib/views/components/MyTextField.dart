import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final Color textColor;
  final Color fillColor;
  final Color cursorColor;
  final String placeholder;
  final double placeholderSize;
  final Color placeholderColor;
  final String suffixIcon;
  final double suffixIconSize;
  final Color focusBorderColor;
  final Color enableBorderColor;
  final Radius borderRadius;
  MyTextField({
    Key? key,
    this.textColor = const Color.fromRGBO(0, 0, 0, 0.5),
    this.fillColor = const Color.fromRGBO(255, 255, 255, 0.5),
    this.cursorColor = const Color.fromRGBO(0, 0, 0, 0.5),
    this.placeholder = '',
    this.placeholderSize = 16,
    this.placeholderColor = const Color.fromRGBO(0, 0, 0, 0.5),
    this.suffixIcon = '',
    this.suffixIconSize = 20,
    this.focusBorderColor = const Color.fromRGBO(0, 0, 0, 0.5),
    this.enableBorderColor = const Color.fromRGBO(0, 0, 0, 0.5),
    this.borderRadius = Radius.zero,
  }) : super(key: key);

  @override
  MyTextFieldState createState() => MyTextFieldState();
}

class MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: widget.cursorColor,
      style: TextStyle(
        fontFamily: 'Montserrat',
        color: widget.textColor,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: widget.fillColor,
        hintText: widget.placeholder,
        hintStyle: TextStyle(
          fontFamily: 'Montserrat',
          color: widget.placeholderColor,
          fontSize: widget.placeholderSize,
        ),
        suffixIcon: Padding(
          padding: EdgeInsets.all(10),
          child: (widget.suffixIcon != '')
              ? Image.asset(
                  widget.suffixIcon,
                  width: widget.suffixIconSize,
                  height: widget.suffixIconSize,
                )
              : null,
        ),
        /*errorText: 'Aucun résultat',
        errorStyle: TextStyle(fontFamily: 'Montserrat'),*/
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.focusBorderColor,
          ),
          borderRadius: BorderRadius.all(widget.borderRadius),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.focusBorderColor,
          ),
          borderRadius: BorderRadius.all(widget.borderRadius),
        ),
      ),
    );
  }
}
