import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/views/components/MyDataTable.dart';
import 'package:smartsfv/views/components/MyText.dart';

class ListTableView extends StatefulWidget {
  final String title;
  final List<String> columns;
  final List<List<String>> rows;
  ListTableView({
    Key? key,
    required this.columns,
    this.rows = const [],
    this.title = 'Nouvelle liste',
  }) : super(key: key);
  @override
  ListTableViewState createState() => ListTableViewState();
}

class ListTableViewState extends State<ListTableView> {
  ///The controller of sliding up panel
  SlidingUpPanelController panelController = SlidingUpPanelController();
  ScrollController scrollController = ScrollController();
  ScrollController datatableScrollController = ScrollController();
  TextEditingController textEditingController = TextEditingController();
  GlobalKey scaffold = GlobalKey();
  @override
  Widget build(BuildContext context) {
    ScreenController.actualView = "LisTableView";
    // Change system UI properties
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    // lock screen orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // Return building scaffold
    return Scaffold(
      key: scaffold,
      floatingActionButton: FloatingActionButton(
        elevation: 5,
        onPressed: () {},
        backgroundColor: Color.fromRGBO(60, 141, 188, 1),
        child: Tooltip(
          message: 'Imprimer',
          decoration: BoxDecoration(
            color: Colors.black,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: TextStyle(
            fontFamily: 'Montserrat',
            color: Color.fromRGBO(60, 141, 188, 1),
            fontSize: 14,
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.normal,
            decoration: TextDecoration.none,
          ),
          child: Icon(
            Icons.print_rounded,
            color: Colors.white,
          ),
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: MyText(
          text: widget.title,
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.white,
        elevation: 10,
        shadowColor: Colors.black.withOpacity(0.2),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
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
                        //todo: Table
                        Row(
                          children: [
                            Expanded(
                              child: FadingEdgeScrollView
                                  .fromSingleChildScrollView(
                                gradientFractionOnStart: 0.2,
                                gradientFractionOnEnd: 0.2,
                                child: SingleChildScrollView(
                                  controller: datatableScrollController,
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  child: MyDataTable(
                                    columns: widget.columns,
                                    rows: widget.rows,
                                  ),
                                ),
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
    );
  }
}
