import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/functions.dart' as functions;
import 'package:smartsfv/views/components/MyText.dart';

class DashboardReloadButton extends StatefulWidget {
  DashboardReloadButton({
    Key? key,
  }) : super(key: key);

  @override
  DashboardReloadButtonState createState() => DashboardReloadButtonState();
}

class DashboardReloadButtonState extends State<DashboardReloadButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  bool get mounted => super.mounted;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return DelayedDisplay(
      delay: Duration(milliseconds: 500),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //todo Title
            MyText(
              text: 'Tableau de bord',
              fontWeight: FontWeight.bold,
            ),
            //todo Button
            InkWell(
              onTap: () {
                ScreenController.reloadDashboard = true;
                // ? Show reloading message
                functions.showMessageToSnackbar(
                  context: context,
                  message: "Actualisation du tableau de bord...",
                  icon: CircularProgressIndicator(
                    color: Color.fromRGBO(60, 141, 188, 1),
                    backgroundColor: Colors.white.withOpacity(0.1),
                    strokeWidth: 5,
                  ),
                );
                // ? Reload dashboard
                setState(() {});
              },
              child: Chip(
                backgroundColor: Color.fromRGBO(60, 141, 188, 0.15),
                label: MyText(
                  text: 'Actualiser',
                  color: Color.fromRGBO(0, 27, 121, 1),
                ),
                avatar: Icon(
                  Icons.refresh_rounded,
                  color: Color.fromRGBO(0, 27, 121, 1),
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
