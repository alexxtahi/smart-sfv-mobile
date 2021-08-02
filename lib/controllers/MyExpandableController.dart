import 'package:expandable/expandable.dart';

class MyExpandableController {
  static Map<String, ExpandableController> expandableControllers = {
    'Paramètres': new ExpandableController(initialExpanded: false),
    'Stocks': new ExpandableController(initialExpanded: false),
    'Boutique': new ExpandableController(initialExpanded: false),
    'Comptabilité': new ExpandableController(initialExpanded: false),
    'Etats': new ExpandableController(initialExpanded: false),
    'Canal': new ExpandableController(initialExpanded: true),
  };
  //todo: Expand only one panel method
  static void expandOnly(String controllerName) {
    for (var controller
        in MyExpandableController.expandableControllers.values) {
      controller.expanded = false;
    }
    MyExpandableController.expandableControllers[controllerName]!.expanded =
        true;
  }
}
