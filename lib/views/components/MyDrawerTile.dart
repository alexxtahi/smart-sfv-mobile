import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/views/components/MyText.dart';

class MyDrawerTile extends StatefulWidget {
  final String icon;
  final double iconSize;
  final String headerText;
  final double headerTextSize;
  final double breakSpace;
  final FontWeight headerTextWeight;
  MyDrawerTile({
    Key? key,
    this.iconSize = 0,
    required this.icon,
    required this.headerText,
    this.headerTextSize = 12,
    this.breakSpace = 1,
    this.headerTextWeight = FontWeight.w600,
  }) : super(key: key);
  @override
  MyDrawerTileState createState() => MyDrawerTileState();
}

class MyDrawerTileState extends State<MyDrawerTile> {
  // Scroll controller
  ScrollController scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    List<double> screenSize = ScreenController.getScreenSize(context);

    return DelayedDisplay(
      delay: Duration(seconds: 2),
      child: Container(
        width: screenSize[0] / widget.breakSpace,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: TextButton(
          onPressed: () {
            print("Pressed: " + widget.headerText);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  widget.icon,
                  color: Color.fromRGBO(1, 21, 122, 1),
                  width: (widget.iconSize != 0) ? widget.iconSize : null,
                  height: (widget.iconSize != 0) ? widget.iconSize : null,
                ),
                SizedBox(width: 10),
                Flexible(
                  child: MyText(
                    text: widget.headerText,
                    color: Colors.white,
                    fontSize: widget.headerTextSize,
                    fontWeight: widget.headerTextWeight,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
            ),
          ),
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.symmetric(horizontal: 0, vertical: 0)),
          ),
        ),
      ),
    );
  }
}
