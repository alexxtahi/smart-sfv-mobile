import 'package:flutter/material.dart';
import 'package:smart_sfv_mobile/controllers/ScreenController.dart';
import 'package:smart_sfv_mobile/views/components/MyText.dart';

class MyDrawerHeader extends StatefulWidget {
  MyDrawerHeader({Key? key}) : super(key: key);

  @override
  MyDrawerHeaderState createState() => MyDrawerHeaderState();
}

class MyDrawerHeaderState extends State<MyDrawerHeader> {
  @override
  Widget build(BuildContext context) {
    List<double> screenSize = ScreenController.getScreenSize(context);
    return Container(
      width: screenSize[0] / 1.25,
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //todo: Profile Picture
          CircleAvatar(
            radius: 40,
            backgroundColor: Color.fromRGBO(1, 21, 122, 1),
            backgroundImage:
                AssetImage('assets/img/backgrounds/storage-center.jpg'),
          ),
          SizedBox(width: 10),
          //todo: Username & role
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  text: 'Alexandre TAHI',
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
                /*MyText(
                  text: "Concepteur de l'application",
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis,
                ),*/
              ],
            ),
          )
        ],
      ),
    );
  }
}
