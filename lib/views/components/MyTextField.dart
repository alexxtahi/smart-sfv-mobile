import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyTextField extends StatefulWidget {
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
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  MyTextField({
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
    this.onSubmitted,
    this.onChanged,
    this.keyboardType,
  }) : super(key: key);

  @override
  MyTextFieldState createState() => MyTextFieldState();
}

class MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: widget.keyboardType,
      focusNode: widget.focusNode,
      onSubmitted: widget.onSubmitted,
      onChanged: widget.onChanged,
      obscureText: (widget.inputType == 'password') ? true : false,
      obscuringCharacter: '•',
      enableSuggestions: (widget.inputType == 'password') ? false : true,
      enableInteractiveSelection:
          (widget.inputType == 'password') ? false : true,
      controller: widget.textEditingController,
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
