import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyTextFormField extends StatefulWidget {
  final Color textColor;
  final Color fillColor;
  final Color cursorColor;
  final String placeholder;
  final double placeholderSize;
  final Color placeholderColor;
  var suffixIcon;
  final double suffixIconSize;
  final double suffixPadding;
  final Color focusBorderColor;
  final Color enableBorderColor;
  final Radius borderRadius;
  final String inputType;
  final String? errorText;
  final FocusNode? focusNode;
  final TextEditingController? textEditingController;
  final void Function()? onTap;
  final void Function()? onEditingComplete;
  final String? Function(String?)? validator;
  MyTextFormField({
    Key? key,
    this.inputType = '',
    this.errorText,
    this.focusNode,
    this.textColor = const Color.fromRGBO(0, 0, 0, 0.5),
    this.fillColor = const Color.fromRGBO(255, 255, 255, 0.5),
    this.cursorColor = const Color.fromRGBO(0, 0, 0, 0.5),
    this.placeholder = '',
    this.placeholderSize = 16,
    this.placeholderColor = const Color.fromRGBO(0, 0, 0, 0.5),
    this.suffixIcon,
    this.suffixIconSize = 20,
    this.suffixPadding = 10,
    this.focusBorderColor = const Color.fromRGBO(0, 0, 0, 0.5),
    this.enableBorderColor = const Color.fromRGBO(0, 0, 0, 0.5),
    this.borderRadius = Radius.zero,
    this.textEditingController,
    this.onTap,
    this.onEditingComplete,
    this.validator,
  }) : super(key: key);

  @override
  MyTextFormFieldState createState() => MyTextFormFieldState();
}

class MyTextFormFieldState extends State<MyTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      validator: widget.validator,
      focusNode: widget.focusNode,
      obscureText: (widget.inputType == 'password') ? true : false,
      obscuringCharacter: '•',
      enableSuggestions: (widget.inputType == 'password') ? false : true,
      enableInteractiveSelection:
          (widget.inputType == 'password') ? false : true,
      onTap: widget.onTap,
      onEditingComplete: widget.onEditingComplete,
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
          padding: EdgeInsets.all(widget.suffixPadding),
          child: (widget.suffixIcon is String)
              ? Image.asset(
                  widget.suffixIcon,
                  width: widget.suffixIconSize,
                  height: widget.suffixIconSize,
                )
              : widget.suffixIcon,
        ),
        errorText: widget.errorText,
        errorStyle: TextStyle(
          fontFamily: 'Montserrat',
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
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
