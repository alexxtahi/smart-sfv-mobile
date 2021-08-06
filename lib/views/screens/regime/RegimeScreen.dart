import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:smartsfv/controllers/DrawerLayoutController.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/views/components/MyAppBar.dart';
import 'package:smartsfv/views/components/MyOutlinedButton.dart';
import 'package:smartsfv/views/components/MyOutlinedIconButton.dart';
import 'package:smartsfv/views/components/MyText.dart';
import 'package:smartsfv/views/components/MyTextField.dart';

class RegimeScreen extends StatefulWidget {
  final SlidingUpPanelController panelController;
  RegimeScreen({Key? key, required this.panelController}) : super(key: key);
  @override
  RegimeScreenState createState() => RegimeScreenState();
}

class RegimeScreenState extends State<RegimeScreen> {
  ScrollController scrollController = new ScrollController();
  ScrollController listViewScrollController = new ScrollController();
  TextEditingController textEditingController = TextEditingController();
  //todo: setState function for the childrens
  void setstate(Function childSetState) {
    /*
    * This function is made to set state of this widget by this childrens
    */
    setState(() {
      childSetState();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<double> screenSize = ScreenController.getScreenSize(context);
    List<String> banklist = [
      for (var i = 1; i <= 50; i++) 'Régime $i',
    ];
    // Return building scaffold
    return AnimatedContainer(
      transform: Matrix4.translationValues(
          DrawerLayoutController.xOffset, DrawerLayoutController.yOffset, 0)
        ..scale(DrawerLayoutController.scaleFactor),
      duration: Duration(milliseconds: 250),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(251, 251, 251, 1),
          borderRadius: DrawerLayoutController.borderRadius,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                //todo: AppBar
                MyAppBar(
                  parentSetState: setstate,
                  panelController: widget.panelController,
                  icon: 'assets/img/icons/regim.png',
                  iconColor: Color.fromRGBO(60, 141, 188, 1),
                  title: 'Régime',
                ),
                SizedBox(height: 20),
                //todo: Search Bar
                MyTextField(
                  focusNode: FocusNode(),
                  textEditingController: this.textEditingController,
                  borderRadius: Radius.circular(20),
                  placeholder: 'Rechercher un régime',
                  textColor: Color.fromRGBO(60, 141, 188, 1),
                  placeholderColor: Color.fromRGBO(60, 141, 188, 1),
                  cursorColor: Colors.black,
                  enableBorderColor: Colors.transparent,
                  focusBorderColor: Colors.transparent,
                  fillColor: Color.fromRGBO(60, 141, 188, 0.15),
                  onSubmitted: (text) {
                    // dismiss keyboard
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  suffixIcon: MyOutlinedIconButton(
                    onPressed: () {
                      // dismiss keyboard
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    backgroundColor: Colors.white,
                    borderColor: Colors.transparent,
                    borderRadius: 15,
                    icon: Icon(
                      Icons.search,
                      color: Color.fromRGBO(60, 141, 188, 1),
                      size: 40,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                //todo: Countries & Filters
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: screenSize[0]),
                  child: GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    childAspectRatio: 4,
                    crossAxisSpacing: 10,
                    children: [
                      MyOutlinedButton(
                        onPressed: () {},
                        backgroundColor: Color.fromRGBO(60, 141, 188, 0.15),
                        borderRadius: 15,
                        borderColor: Colors.transparent,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.edit_rounded,
                              color: Color.fromRGBO(0, 27, 121, 1),
                            ),
                            SizedBox(width: 15),
                            MyText(
                              text: 'Modifier',
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(0, 27, 121, 1),
                            ),
                          ],
                        ),
                      ),
                      MyOutlinedButton(
                        onPressed: () {},
                        backgroundColor: Color.fromRGBO(221, 75, 57, 0.15),
                        borderRadius: 15,
                        borderColor: Colors.transparent,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.delete_outline_rounded,
                              color: Color.fromRGBO(187, 0, 0, 1),
                            ),
                            SizedBox(width: 15),
                            MyText(
                              text: 'Supprimer',
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(187, 0, 0, 1),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                //todo: List title
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 5,
                      backgroundColor: Color.fromRGBO(60, 141, 188, 1),
                    ),
                    SizedBox(width: 10),
                    MyText(
                      text: 'Liste des régimes',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color.fromRGBO(60, 141, 188, 1),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                //todo: Scrolling View
                Expanded(
                  child: FadingEdgeScrollView.fromSingleChildScrollView(
                    gradientFractionOnStart: 0.05,
                    gradientFractionOnEnd: 0.2,
                    child: SingleChildScrollView(
                      controller: scrollController,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          //todo: ListView
                          Row(
                            children: [
                              Expanded(
                                child: ListView.separated(
                                  controller: this.listViewScrollController,
                                  shrinkWrap: true,
                                  itemCount: banklist.length,
                                  scrollDirection:
                                      Axis.vertical, // direction of scrolling
                                  separatorBuilder: (context, index) =>
                                      SizedBox(width: 20.0),
                                  itemBuilder: (context, index) {
                                    // other cards
                                    return ListTile(
                                      enableFeedback: true,
                                      onTap: () {
                                        print(banklist[index] + ' on tap !');
                                      },
                                      onLongPress: () {
                                        print(
                                            banklist[index] + ' long press !');
                                      },
                                      leading: CircleAvatar(
                                        radius: 20,
                                        backgroundColor:
                                            Color.fromRGBO(60, 141, 188, 0.15),
                                        child: MyText(
                                          text: (index + 1).toString(),
                                          color:
                                              Color.fromRGBO(60, 141, 188, 1),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      title: MyText(
                                        text: banklist[index],
                                        //fontWeight: FontWeight.bold,
                                      ),
                                      selectedTileColor:
                                          Color.fromRGBO(60, 141, 188, 0.15),
                                      focusColor:
                                          Color.fromRGBO(60, 141, 188, 0.15),
                                      hoverColor:
                                          Color.fromRGBO(60, 141, 188, 0.15),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
