import 'package:flutter/material.dart';
import 'package:smartsfv/controllers/DrawerLayoutController.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/views/screens/article/ArticleView.dart';
import 'package:smartsfv/views/screens/client/ClientView.dart';
import 'package:smartsfv/views/screens/commande/CommandeView.dart';
import 'package:smartsfv/views/screens/fournisseur/ProviderView.dart';
import 'package:smartsfv/views/components/DashboardCard.dart';
import 'package:smartsfv/functions.dart' as functions;

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
            cardName: 'getClients',
            iconColor: Color.fromRGBO(0, 27, 121, 1),
            onPressed: () {
              print('Dashboard card Client appuyé !');
              functions.openPage(
                context,
                ClientView(),
                //mode: 'pushReplacement',
              );
              setState(() {
                DrawerLayoutController.close();
              });
            },
          ),
          DashboardCard(
            text: 'Articles',
            icon: 'assets/img/icons/box.png',
            cardName: 'getArticles',
            iconColor: Color.fromRGBO(231, 57, 0, 1),
            backgroundColor: Color.fromRGBO(243, 156, 18, 1),
            onPressed: () {
              print('Dashboard card Article appuyé !');
              functions.openPage(
                context,
                ArticleView(),
                //mode: 'pushReplacement',
              );
              setState(() {
                DrawerLayoutController.close();
              });
            },
          ),
          DashboardCard(
            text: 'Commandes',
            icon: 'assets/img/icons/shopping-cart1.png',
            cardName: 'getCommandes',
            //iconColor: Color.fromRGBO(60, 141, 188, 1),
            //backgroundColor: Color.fromRGBO(0, 27, 121, 1),
            iconColor: Color.fromRGBO(0, 77, 0, 1), // ! old
            backgroundColor: Color.fromRGBO(0, 166, 90, 1), // ! old
            onPressed: () {
              print('Dashboard card Commande appuyé !');
              functions.openPage(
                context,
                CommandeView(),
                //mode: 'pushReplacement',
              );
              setState(() {
                DrawerLayoutController.close();
              });
            },
          ),
          DashboardCard(
            text: 'Fournisseurs',
            icon: 'assets/img/icons/provider.png',
            cardName: 'getFournisseurs',
            iconColor: Color.fromRGBO(187, 0, 0, 1),
            backgroundColor: Color.fromRGBO(221, 75, 57, 1),
            onPressed: () {
              print('Dashboard card Fournisseur appuyé !');
              functions.openPage(
                context,
                ProviderView(),
                //mode: 'pushReplacement',
              );
              setState(() {
                DrawerLayoutController.close();
              });
            },
          ),
        ],
      ),
    );
  }
}
