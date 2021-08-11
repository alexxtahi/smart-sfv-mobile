import 'package:flutter/material.dart';
import 'package:smartsfv/views/components/MyText.dart';

class ErrorLayout extends StatefulWidget {
  final String message;
  final String image;
  const ErrorLayout({
    Key? key,
    this.image = 'assets/img/icons/sad.png',
    this.message = "Une erreur s'est produite",
  }) : super(key: key);

  @override
  ErrorLayoutState createState() => ErrorLayoutState();
}

class ErrorLayoutState extends State<ErrorLayout> {
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                widget.image,
                fit: BoxFit.contain,
                width: 100,
                height: 100,
                color: Color.fromRGBO(60, 141, 188, 0.5),
              ),
              SizedBox(
                height: 10,
              ),
              Flexible(
                child: MyText(
                  text: widget.message,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(60, 141, 188, 0.5),
                  overflow: TextOverflow.visible,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
