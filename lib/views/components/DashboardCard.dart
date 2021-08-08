import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:smartsfv/api.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/views/components/MyText.dart';
import 'package:smartsfv/functions.dart' as functions;

class DashboardCard extends StatefulWidget {
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final String icon;
  final double iconSize;
  final Color iconColor;
  final Radius borderRadius;
  final void Function()? onPressed;
  final String cardName;
  DashboardCard({
    Key? key,
    required this.text,
    required this.cardName,
    this.textColor = Colors.white,
    this.backgroundColor = const Color.fromRGBO(60, 141, 188, 1),
    required this.icon,
    this.iconSize = 70,
    this.iconColor = Colors.black,
    this.borderRadius = const Radius.circular(20),
    this.onPressed,
    // default card value
  }) : super(key: key);

  @override
  DashboardCardState createState() => DashboardCardState();
}

class DashboardCardState extends State<DashboardCard> {
  @override
  Widget build(BuildContext context) {
    List<double> screenSize = ScreenController.getScreenSize(context);
    return DelayedDisplay(
      delay: Duration(milliseconds: 500),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.symmetric(horizontal: 0, vertical: 0)),
            backgroundColor: MaterialStateProperty.all<Color>(
              widget.backgroundColor,
            ), // ! debug
            side: MaterialStateProperty.all<BorderSide>(
                BorderSide(color: Colors.transparent)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          child: Container(
            width: screenSize[0] / 2.2,
            height: 150,
            decoration: BoxDecoration(
              //color: widget.backgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  //todo: Icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset(
                        widget.icon,
                        width: widget.iconSize,
                        height: widget.iconSize,
                        fit: BoxFit.contain,
                        color: widget.iconColor,
                        //colorBlendMode: BlendMode.colorBurn,
                      ),
                    ],
                  ),
                  //todo: Texts
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //todo: Value
                      FutureBuilder<Map<String, int>>(
                        future: this.getDashboardDatas(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            // ? Check if the list of clients is empty or not
                            return (snapshot.data![widget.cardName] == null)
                                ? Text(
                                    '0',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Colors.white,
                                      //color: Colors.black,
                                      fontSize: 40,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  )
                                : Text(
                                    snapshot.data![widget.cardName].toString(),
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Colors.white,
                                      //color: Colors.black,
                                      fontSize: 40,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  );
                          } else if (snapshot.hasError) {
                            functions.errorSnackbar(
                              context: context,
                              message: 'Erreur sur le tableau de bord',
                            );
                            return Text(
                              'Erreur',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                                //color: Colors.black,
                                fontSize: 40,
                                fontWeight: FontWeight.w800,
                              ),
                            );
                          }

                          //todo: Loading indicator
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(
                                  color: Colors.white,
                                  backgroundColor: Colors.transparent,
                                  semanticsLabel: 'Chargement des clients',
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      //todo: Title
                      Text(
                        widget.text,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: widget.textColor,
                          //color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  //todo: See More Button
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //todo: Text
                          Text(
                            'Voir',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: widget.textColor,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(width: 5),
                          //todo: Icon
                          Image.asset(
                            'assets/img/icons/previous.png',
                            width: 20,
                            height: 20,
                            fit: BoxFit.contain,
                            color: widget.iconColor,
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<Map<String, int>> getDashboardDatas() async {
    // init API instance
    Api api = Api();
    // call API method getDashboardDatas
    Map<String, int> dashboardDatas = await api.getDashboardStats();
    // return dashboard datas
    return dashboardDatas;
  }
}
