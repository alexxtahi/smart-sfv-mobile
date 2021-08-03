import 'package:flutter/material.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/views/ClientView.dart';
import 'package:smartsfv/views/components/DashboardCard.dart';
import 'package:smartsfv/controllers/functions.dart' as functions;

class DashboardGridViewLayout extends StatefulWidget {
  final ScrollController gridViewScrollController;
  final EdgeInsets padding;
  final int elementsPerLine;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final Axis scrollDirection;
  final double childAspectRatio;

  DashboardGridViewLayout({
    Key? key,
    required this.gridViewScrollController,
    required this.elementsPerLine,
    required this.childAspectRatio,
    this.crossAxisSpacing = 2,
    this.mainAxisSpacing = 2,
    this.scrollDirection = Axis.vertical,
    this.padding = const EdgeInsets.all(0),
  }) : super(key: key);

  @override
  DashboardGridViewLayoutState createState() => DashboardGridViewLayoutState();
}

class DashboardGridViewLayoutState extends State<DashboardGridViewLayout> {
  @override
  Widget build(BuildContext context) {
    List<double> screenSize = ScreenController.getScreenSize(context);
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: screenSize[0],
      ),
      child: GridView.count(
        controller: widget.gridViewScrollController,
        crossAxisCount: widget.elementsPerLine,
        crossAxisSpacing: widget.crossAxisSpacing,
        mainAxisSpacing: widget.mainAxisSpacing,
        childAspectRatio: widget.childAspectRatio,
        shrinkWrap: true,
        //physics:BouncingScrollPhysics(),
        padding: widget.padding,
        scrollDirection: widget.scrollDirection,
        children: [
          DashboardCard(
            text: 'Clients',
            icon: 'assets/img/icons/customer1.png',
            iconColor: Color.fromRGBO(0, 27, 121, 1),
            onPressed: () {
              print('Bash Client appuyé !');
              functions.openPage(context, ClientView());
            },
          ),
          DashboardCard(
            text: 'Articles',
            icon: 'assets/img/icons/box.png',
            iconColor: Color.fromRGBO(231, 57, 0, 1),
            backgroundColor: Color.fromRGBO(243, 156, 18, 1),
          ),
          DashboardCard(
            text: 'Dépôts',
            icon: 'assets/img/icons/bank.png',
            iconColor: Color.fromRGBO(0, 77, 0, 1),
            backgroundColor: Color.fromRGBO(0, 166, 90, 1),
          ),
          DashboardCard(
            text: 'Fournisseurs',
            icon: 'assets/img/icons/provider.png',
            iconColor: Color.fromRGBO(187, 0, 0, 1),
            backgroundColor: Color.fromRGBO(221, 75, 57, 1),
          ),
        ],
      ),
    );
  }
}
