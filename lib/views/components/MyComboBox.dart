import 'package:flutter/material.dart';
import 'package:smartsfv/views/components/MyText.dart';

// ignore: must_be_immutable
class MyComboBox extends StatefulWidget {
  final String initialDropDownValue;
  final List<String> initialDropDownList;
  final double iconSize;
  final int elevation;
  final Color textColor;
  final Color fillColor;
  final FontWeight textFontWeight;
  final double textFontSize;
  var suffixIcon;
  Widget? prefixIcon;
  final double suffixIconSize;
  final double suffixPadding;
  final double prefixPadding;
  final Color focusBorderColor;
  final Color enableBorderColor;
  final Color errorColor;
  final Radius borderRadius;
  final TextOverflow textOverflow;
  final String? errorText;
  final FocusNode? focusNode;
  final void Function()? onTap;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  var menuItem;

  MyComboBox({
    Key? key,
    this.initialDropDownValue = 'Sélectionnez...',
    this.initialDropDownList = const ['Sélectionnez...'],
    this.iconSize = 24,
    this.elevation = 16,
    this.errorText,
    this.focusNode,
    this.textColor = const Color.fromRGBO(60, 141, 188, 1),
    this.fillColor = const Color.fromRGBO(255, 255, 255, 0.5),
    this.prefixIcon,
    this.suffixIcon,
    this.suffixIconSize = 20,
    this.suffixPadding = 10,
    this.prefixPadding = 10,
    this.focusBorderColor = const Color.fromRGBO(0, 0, 0, 0.5),
    this.enableBorderColor = const Color.fromRGBO(0, 0, 0, 0.5),
    this.errorColor = Colors.red,
    this.borderRadius = Radius.zero,
    this.onTap,
    this.onChanged,
    this.validator,
    this.textFontWeight = FontWeight.normal,
    this.textFontSize = 14,
    this.textOverflow = TextOverflow.ellipsis,
    this.menuItem,
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
    return DropdownButtonFormField<String>(
      onTap: widget.onTap,
      iconEnabledColor: widget.textColor,
      isExpanded: true,
      validator: widget.validator,
      value: this.dropDownValue,
      icon: Icon(Icons.keyboard_arrow_down_rounded),
      iconSize: widget.iconSize,
      elevation: widget.elevation,
      style: TextStyle(
        fontFamily: 'Montserrat',
        color: widget.textColor,
        fontSize: 14,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.normal,
        decoration: TextDecoration.none,
      ),
      onChanged: (widget.onChanged != null)
          ? widget.onChanged
          : (String? newDropDownValue) {
              setState(() {
                this.dropDownValue = newDropDownValue!;
              });
            },
      items: this.dropDownList.map<DropdownMenuItem<String>>(
        (String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: (widget.menuItem != null)
                ? widget.menuItem
                : Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Flexible(
                        child: MyText(
                          text: value,
                          color: widget.textColor,
                          fontSize: widget.textFontSize,
                          fontWeight: widget.textFontWeight,
                          overflow: widget.textOverflow,
                        ),
                      ),
                    ],
                  ),
          );
        },
      ).toList(),
      decoration: InputDecoration(
        prefixIcon: (widget.prefixIcon != null)
            ? Padding(
                padding: EdgeInsets.all(widget.prefixPadding),
                child: widget.prefixIcon,
              )
            : null,
        filled: true,
        fillColor: widget.fillColor,
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
      ),
    );
  }
}
