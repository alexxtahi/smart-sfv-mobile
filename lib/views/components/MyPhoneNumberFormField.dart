import 'package:flutter/material.dart';
import 'package:phonenumbers/phonenumbers.dart';

// ignore: must_be_immutable
class MyPhoneNumberFormField extends StatefulWidget {
  final Color textColor;
  final Color fillColor;
  final String placeholder;
  final double placeholderSize;
  final Color placeholderColor;
  var suffixIcon;
  Widget? prefixIcon;
  final double suffixIconSize;
  final double suffixPadding;
  final double prefixPadding;
  final Color focusBorderColor;
  final Color enableBorderColor;
  final Radius borderRadius;
  final String? errorText;
  final String? errorMessage;
  final String? labelText;
  final Color labelTextColor;
  final Color errorColor;
  final FocusNode? focusNode;
  final PhoneNumberEditingController? controller;
  MyPhoneNumberFormField({
    Key? key,
    this.errorText,
    this.errorMessage = "Numéro de téléphone incorrect",
    this.focusNode,
    this.textColor = const Color.fromRGBO(0, 0, 0, 0.5),
    this.fillColor = const Color.fromRGBO(255, 255, 255, 0.5),
    this.placeholder = '',
    this.placeholderSize = 16,
    this.placeholderColor = const Color.fromRGBO(0, 0, 0, 0.5),
    this.prefixIcon,
    this.suffixIcon,
    this.suffixIconSize = 20,
    this.suffixPadding = 10,
    this.prefixPadding = 10,
    this.focusBorderColor = const Color.fromRGBO(0, 0, 0, 0.5),
    this.enableBorderColor = const Color.fromRGBO(0, 0, 0, 0.5),
    this.borderRadius = Radius.zero,
    this.controller,
    this.labelText,
    this.labelTextColor = const Color.fromRGBO(0, 0, 0, 0.5),
    this.errorColor = Colors.red,
  }) : super(key: key);

  @override
  MyPhoneNumberFormFieldState createState() => MyPhoneNumberFormFieldState();
}

class MyPhoneNumberFormFieldState extends State<MyPhoneNumberFormField> {
  @override
  Widget build(BuildContext context) {
    return PhoneNumberFormField(
      controller: widget.controller,
      countryCodeWidth: 120,
      errorMessage: widget.errorMessage!,
      style: TextStyle(
        fontFamily: 'Montserrat',
        color: widget.textColor,
      ),
      decoration: InputDecoration(
        labelText: widget.labelText,
        prefixIcon: (widget.prefixIcon != null)
            ? Padding(
                padding: EdgeInsets.all(widget.prefixPadding),
                child: widget.prefixIcon,
              )
            : null,
        labelStyle: TextStyle(
          fontFamily: 'Montserrat',
          color: widget.labelTextColor,
          fontSize: widget.placeholderSize,
        ),
        filled: true,
        fillColor: widget.fillColor,
        hintText: widget.placeholder,
        hintStyle: TextStyle(
          fontFamily: 'Montserrat',
          color: widget.placeholderColor,
          fontSize: widget.placeholderSize,
        ),
        suffixIcon: (widget.suffixIcon != null)
            ? Padding(
                padding: EdgeInsets.all(widget.suffixPadding),
                child: (widget.suffixIcon is String)
                    ? Image.asset(
                        widget.suffixIcon,
                        width: widget.suffixIconSize,
                        height: widget.suffixIconSize,
                      )
                    : widget.suffixIcon,
              )
            : null,
        errorText: widget.errorText,
        errorStyle: TextStyle(
          fontFamily: 'Montserrat',
          color: widget.errorColor,
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
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.errorColor,
          ),
          borderRadius: BorderRadius.all(widget.borderRadius),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.all(widget.borderRadius),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.focusBorderColor,
          ),
          borderRadius: BorderRadius.all(widget.borderRadius),
        ),
      ),
    );
  }
}
