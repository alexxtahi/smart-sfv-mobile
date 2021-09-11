import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:smartsfv/functions.dart' as functions;
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartsfv/api.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/models/Client.dart';
import 'package:smartsfv/models/Pays.dart';
import 'package:smartsfv/models/Regime.dart';
import 'package:smartsfv/models/Research.dart';
import 'package:smartsfv/views/components/MyComboBox.dart';
import 'package:smartsfv/views/components/MyDataTable.dart';
import 'package:smartsfv/views/components/MyOutlinedButton.dart';
import 'package:smartsfv/views/components/MyOutlinedIconButton.dart';
import 'package:smartsfv/views/components/MyText.dart';
import 'package:smartsfv/views/components/MyTextField.dart';
import 'package:smartsfv/views/components/MyTextFormField.dart';
import 'package:smartsfv/views/screens/client/AchatClientFutureBuilder.dart';

class FicheClientView extends StatefulWidget {
  final ValueChanged<Function> parentSetState;
  FicheClientView({
    Key? key,
    required this.parentSetState,
  }) : super(key: key);
  @override
  FicheClientViewState createState() => FicheClientViewState();
}

class FicheClientViewState extends State<FicheClientView> {
  //todo: Method called when the view is launching
  @override
  void initState() {
    super.initState();
    // ? Launching configs
    if (ScreenController.actualView != "LoginView") {
      ScreenController.actualView = "FicheClientView";
      ScreenController.isChildView = true;
    }
  }

  //todo: Method called when the view is closing
  @override
  void dispose() {
    // ? Set actualView to "HomeView"
    if (ScreenController.actualView != "LoginView") {
      ScreenController.actualView = "ClientView";
      ScreenController.isChildView = true;
    }
    super.dispose();
  }

  ScrollController mainScrollController = ScrollController();
  TextEditingController numberFactureController = TextEditingController();
  Api api = Api();
  GlobalKey scaffold = GlobalKey();

  @override
  Widget build(BuildContext context) {
    List<double> screenSize = ScreenController.getScreenSize(context);
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Flex(
            direction: Axis.vertical,
            children: [
              //todo: BackButton & Title
              Row(
                children: [
                  //todo: BackButton
                  MyOutlinedIconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Color.fromRGBO(60, 141, 188, 1),
                      size: 40,
                    ),
                    iconSize: 30,
                    size: 50,
                    borderRadius: 15,
                    borderColor: Color.fromRGBO(60, 141, 188, 1),
                    backgroundColor: Color.fromRGBO(60, 141, 188, 0.15),
                    onPressed: () {
                      print("isChildView -> " +
                          ScreenController.isChildView.toString()); // ! debug
                      Navigator.of(context).pop();
                      // ? Reload client table
                      widget.parentSetState(() {
                        ScreenController.isChildView = false;
                        MyDataTable.selectedRowIndex = null;
                        Client.client = null;
                        Research.reset(); // Reset last research datas
                      });
                    },
                  ),
                  SizedBox(width: 15),
                  //todo: Title
                  MyText(
                    text: 'Fiche client',
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              SizedBox(height: 10),
              //todo: Scrollable view
              Expanded(
                child: FadingEdgeScrollView.fromSingleChildScrollView(
                  gradientFractionOnStart: 0.2,
                  gradientFractionOnEnd: 0.2,
                  child: SingleChildScrollView(
                    controller: mainScrollController,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        //todo: Client Infos
                        Container(
                          width: screenSize[0],
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(60, 141, 188, 0.5),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              //todo: Client Avatar
                              CircleAvatar(
                                radius: 50,
                                backgroundColor:
                                    Color.fromRGBO(60, 141, 188, 0.5),
                                child: Icon(
                                  Icons.account_circle,
                                  color: Colors.white,
                                  size: 100,
                                ),
                              ),
                              SizedBox(width: 15),
                              //todo: Client Name & Contact
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //todo: Client Name
                                  MyText(
                                    text: (Client.client != null)
                                        ? Client.client!.nom
                                        : "Inconnu",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                  SizedBox(height: 10),
                                  //todo: Client Name
                                  MyText(
                                    text: (Client.client != null)
                                        ? Client.client!.contact
                                        : "Contact",
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        //todo: Liste des achats
                        MyText(
                          text: "Liste des achats",
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                        SizedBox(height: 10),
                        //todo: Search Bar
                        MyTextField(
                          keyboardType: TextInputType.text,
                          focusNode: FocusNode(),
                          textEditingController: this.numberFactureController,
                          borderRadius: Radius.circular(20),
                          placeholder: 'Rechercher par Nº de facture',
                          placeholderColor: Color.fromRGBO(60, 141, 188, 1),
                          cursorColor: Colors.black,
                          textColor: Color.fromRGBO(60, 141, 188, 1),
                          enableBorderColor: Colors.transparent,
                          focusBorderColor: Colors.transparent,
                          fillColor: Color.fromRGBO(60, 141, 188, 0.15),
                          onChanged: (text) {
                            /*
                            // ? Check if the field is empty or not
                            setState(() {
                              if (this.numberFactureController.text.isEmpty)
                                Research.reset(); // Reset last research datas
                              else
                                // launch research
                                Research.find(
                                  'Client',
                                  this.numberFactureController.text,
                                );
                            });
                            */
                          },
                          onSubmitted: (text) {
                            /*
                            // dismiss keyboard
                            FocusScope.of(context).requestFocus(FocusNode());
                            // ? Check if the field is empty or not
                            setState(() {
                              if (this.numberFactureController.text.isEmpty)
                                Research.reset(); // Reset last research datas
                              else
                                // launch research
                                Research.find(
                                  'Client',
                                  this.numberFactureController.text,
                                );
                            });
                            */
                          },
                          suffixIcon: MyOutlinedIconButton(
                            onPressed: () {
                              /*
                              // dismiss keyboard
                              FocusScope.of(context).requestFocus(FocusNode());
                              // ? Check if the field is empty or not
                              setState(() {
                                if (this.numberFactureController.text.isEmpty)
                                  Research.reset(); // Reset last research datas
                                else
                                  // launch research
                                  Research.find(
                                    'Client',
                                    this.numberFactureController.text,
                                  );
                              });
                              */
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
                        //todo: Date pickers
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            //todo: Start date button
                            MyOutlinedButton(
                              onPressed: () {
                                DatePicker.showDatePicker(
                                  context,
                                  showTitleActions: true,
                                  minTime: DateTime(2021, 1, 1),
                                  maxTime: DateTime(2050, 12, 31),
                                  currentTime: DateTime.now(),
                                  theme: DatePickerTheme(
                                    itemStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Color.fromRGBO(0, 27, 121, 1),
                                      fontSize: 16,
                                    ),
                                    doneStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                    ),
                                    cancelStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Colors.black54,
                                    ),
                                  ),
                                  onChanged: (date) {
                                    print('change $date');
                                  },
                                  onConfirm: (date) {
                                    print('confirm $date');
                                  },
                                  locale: LocaleType.fr,
                                );
                              },
                              width: screenSize[0] / 2.27,
                              backgroundColor:
                                  Color.fromRGBO(60, 141, 188, 0.15),
                              borderRadius: 15,
                              borderColor: Colors.transparent,
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Image.asset(
                                    'assets/img/icons/calendar.png',
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.contain,
                                    color: Color.fromRGBO(0, 27, 121, 1),
                                  ),
                                  SizedBox(width: 15),
                                  Flexible(
                                    child: MyText(
                                      text: 'Date de début',
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(0, 27, 121, 1),
                                      overflow: TextOverflow.visible,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //todo: End date button
                            MyOutlinedButton(
                              onPressed: () {
                                DatePicker.showDatePicker(
                                  context,
                                  showTitleActions: true,
                                  minTime: DateTime(2021, 1, 1),
                                  maxTime: DateTime(2050, 12, 31),
                                  currentTime:
                                      DateTime.now().add(Duration(days: 1)),
                                  theme: DatePickerTheme(
                                    itemStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Color.fromRGBO(0, 27, 121, 1),
                                      fontSize: 16,
                                    ),
                                    doneStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                    ),
                                    cancelStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Colors.black54,
                                    ),
                                  ),
                                  onChanged: (date) {
                                    print('change $date');
                                  },
                                  onConfirm: (date) {
                                    print('confirm $date');
                                  },
                                  locale: LocaleType.fr,
                                );
                              },
                              width: screenSize[0] / 2.27,
                              backgroundColor:
                                  Color.fromRGBO(60, 141, 188, 0.15),
                              borderRadius: 15,
                              borderColor: Colors.transparent,
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Image.asset(
                                    'assets/img/icons/calendar.png',
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.contain,
                                    color: Color.fromRGBO(0, 27, 121, 1),
                                  ),
                                  SizedBox(width: 15),
                                  Flexible(
                                    child: MyText(
                                      text: 'Date de fin',
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(0, 27, 121, 1),
                                      overflow: TextOverflow.visible,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        //todo: DataTable
                        AchatClientFutureBuilder(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          //color: Colors.black,
          borderRadius: BorderRadius.circular(25),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            elevation: 0,
            type: BottomNavigationBarType.shifting,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
            iconSize: 35.0,
            items: [
              BottomNavigationBarItem(
                backgroundColor: Color.fromRGBO(60, 141, 188, 0.15),
                icon: IconButton(
                  onPressed: () {
                    if (Client.client != null) {
                      // TextFormField controllers
                      Map<String, dynamic> fieldControllers = {
                        'name': TextEditingController(),
                        'contact':
                            TextEditingController(), //'contact': PhoneNumberEditingController(),
                        'email': TextEditingController(),
                        'pays': 0,
                        'geoAdr': TextEditingController(),
                        'postalAdr': TextEditingController(),
                        'regime': 0,
                        'montantPlafond': TextEditingController(),
                        'fax': TextEditingController(),
                        'compteContrib': TextEditingController(),
                      };
                      // ? Preset fields
                      fieldControllers['name'].text = Client.client!.nom;
                      fieldControllers['contact'].text = Client.client!.contact;
                      fieldControllers['email'].text = Client.client!.email;
                      fieldControllers['geoAdr'].text = Client.client!.adresse;
                      fieldControllers['postalAdr'].text =
                          Client.client!.boitePostale;
                      fieldControllers['montantPlafond'].text =
                          Client.client!.montantPlafond;
                      fieldControllers['fax'].text = Client.client!.fax;
                      fieldControllers['compteContrib'].text =
                          Client.client!.compteContrib;
                      // ? show update form
                      GlobalKey<FormState> formKey = GlobalKey<FormState>();
                      functions.showFormDialog(
                        scaffold.currentContext,
                        formKey,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        headerIcon: 'assets/img/icons/customer.png',
                        title: 'Modifier un client',
                        onValidate: () async {
                          if (formKey.currentState!.validate()) {
                            // ? sending datas to API
                            Api api = Api();
                            Client clientToUpdate = Client.client!;
                            final Map<String, dynamic> updateClientResponse =
                                await api.updateClient(
                              client: Client.fromJson({
                                'id': clientToUpdate.id,
                                'full_name_client': fieldControllers['name']
                                    .text, // get name  // ! required
                                'contact_client':
                                    (fieldControllers['pays'] == 51)
                                        ? // ? Normalize Ivoirian phone numbers
                                        functions.normalizePhoneNumber(
                                            fieldControllers['contact'].text)
                                        : fieldControllers['contact']
                                            .text, // get contact // ! required
                                'email_client':
                                    (fieldControllers['email'].text != null)
                                        ? fieldControllers['email'].text
                                        : '', // get email
                                'nation': {
                                  'id': fieldControllers['pays'],
                                }, // get pays // ! required
                                'adresse_client':
                                    (fieldControllers['geoAdr'].text != null)
                                        ? fieldControllers['geoAdr'].text
                                        : '', // get geoAdr
                                'boite_postale_client':
                                    (fieldControllers['postalAdr'].text != null)
                                        ? fieldControllers['postalAdr'].text
                                        : '', // get postalAdr
                                'regime': {
                                  'id': fieldControllers['regime'],
                                }, // get regime // ! required
                                'plafond_client':
                                    (fieldControllers['montantPlafond'].text !=
                                            null)
                                        ? fieldControllers['montantPlafond']
                                            .text
                                        : '', // get montant plafond
                                'fax_client':
                                    (fieldControllers['fax'].text != null)
                                        ? fieldControllers['fax'].text
                                        : '', // get fax
                                'compte_contribuable_client':
                                    (fieldControllers['compteContrib'].text !=
                                            null)
                                        ? fieldControllers['compteContrib'].text
                                        : '', // get compte contribuable
                              }),
                            );
                            // ? check the server response
                            if (updateClientResponse['msg'] ==
                                'Modification effectuée avec succès.') {
                              // ? In Success case
                              Navigator.of(context).pop();
                              functions.showSuccessDialog(
                                context: context,
                                message: 'Modification réussie !',
                              );
                              // ? Reload page
                              setState(() {
                                Client.client = Client.fromJson(
                                    updateClientResponse['data']);
                              });
                            } else {
                              // ? In Error case
                              Navigator.of(context).pop();
                              functions.showErrorDialog(
                                context: context,
                                message: "Une erreur s'est produite",
                              );
                            }
                            // ? Refresh client list
                            setState(() {});
                          }
                        },
                        formElements: [
                          //todo: Name Field
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //todo: Name label
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  MyText(
                                    text: 'Nom & prénom(s)',
                                    color: Color.fromRGBO(0, 27, 121, 1),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  CircleAvatar(
                                    radius: 5,
                                    backgroundColor:
                                        Color.fromRGBO(221, 75, 57, 1),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              //todo: Name TextFormField
                              MyTextFormField(
                                textEditingController: fieldControllers['name'],
                                validator: (value) {
                                  return value!.isNotEmpty
                                      ? null
                                      : 'Saisissez le nom du client';
                                },
                                prefixPadding: 10,
                                prefixIcon: Image.asset(
                                  'assets/img/icons/account.png',
                                  fit: BoxFit.contain,
                                  width: 15,
                                  height: 15,
                                  color: Color.fromRGBO(60, 141, 188, 1),
                                ),
                                placeholder: 'Nom & prénom(s)',
                                textColor: Color.fromRGBO(60, 141, 188, 1),
                                placeholderColor:
                                    Color.fromRGBO(60, 141, 188, 1),
                                fillColor: Color.fromRGBO(60, 141, 188, 0.15),
                                borderRadius: Radius.circular(10),
                                focusBorderColor: Colors.transparent,
                                enableBorderColor: Colors.transparent,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          //todo: Contact Field
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //todo: Contact label
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  MyText(
                                    text: 'Contact',
                                    color: Color.fromRGBO(0, 27, 121, 1),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  CircleAvatar(
                                    radius: 5,
                                    backgroundColor:
                                        Color.fromRGBO(221, 75, 57, 1),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              //todo: Contact TextFormField
                              MyTextFormField(
                                keyboardType: TextInputType.number,
                                textEditingController:
                                    fieldControllers['contact'],
                                validator: (value) {
                                  if (value!.isNotEmpty) {
                                    // ? For ivoirian number
                                    if (fieldControllers['pays'] == 51) {
                                      if (value.length == 10)
                                        return null;
                                      else
                                        return 'Numéro de téléphone incorrect';
                                    } else {
                                      // ? For all other numbers
                                      return null;
                                    }
                                  } else {
                                    return 'Saisissez le contact du client';
                                  }
                                },
                                prefixPadding: 10,
                                prefixIcon: Icon(
                                  Icons.phone_android_rounded,
                                  color: Color.fromRGBO(60, 141, 188, 1),
                                ),
                                placeholder: 'Contact du client',
                                textColor: Color.fromRGBO(60, 141, 188, 1),
                                placeholderColor:
                                    Color.fromRGBO(60, 141, 188, 1),
                                fillColor: Color.fromRGBO(60, 141, 188, 0.15),
                                borderRadius: Radius.circular(10),
                                focusBorderColor: Colors.transparent,
                                enableBorderColor: Colors.transparent,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          //todo: Email Field
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //todo: Email label
                              MyText(
                                text: 'Email',
                                color: Color.fromRGBO(0, 27, 121, 1),
                                fontWeight: FontWeight.bold,
                              ),
                              SizedBox(height: 5),
                              //todo: Email TextFormField
                              MyTextFormField(
                                textEditingController:
                                    fieldControllers['email'],
                                prefixPadding: 10,
                                prefixIcon: Icon(
                                  Icons.mail_outline_rounded,
                                  color: Color.fromRGBO(60, 141, 188, 1),
                                ),
                                placeholder: 'Adresse mail du client',
                                textColor: Color.fromRGBO(60, 141, 188, 1),
                                placeholderColor:
                                    Color.fromRGBO(60, 141, 188, 1),
                                fillColor: Color.fromRGBO(60, 141, 188, 0.15),
                                borderRadius: Radius.circular(10),
                                focusBorderColor: Colors.transparent,
                                enableBorderColor: Colors.transparent,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          //todo: Pays Field
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //todo: Pays label
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  MyText(
                                    text: 'Pays',
                                    color: Color.fromRGBO(0, 27, 121, 1),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  CircleAvatar(
                                    radius: 5,
                                    backgroundColor:
                                        Color.fromRGBO(221, 75, 57, 1),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              //todo: Pays DropDown
                              (ScreenController.actualView != "LoginView")
                                  ? FutureBuilder<List<Pays>>(
                                      future: api.getPays(context),
                                      builder: (paysComboBoxContext, snapshot) {
                                        if (snapshot.hasData) {
                                          // ? get nations datas from server
                                          return MyComboBox(
                                            validator: (value) {
                                              return value! !=
                                                      'Sélectionnez un pays'
                                                  ? null
                                                  : 'Choisissez un pays';
                                            },
                                            onChanged: (value) {
                                              // ? Iterate all countries to get the selected countrie id
                                              for (var pays in snapshot.data!) {
                                                if (pays.libelle == value) {
                                                  fieldControllers['pays'] = pays
                                                      .id; // save the new countrie selected
                                                  print(
                                                      "Nouveau pays: $value, ${fieldControllers['pays']}, ${pays.id}");
                                                  break;
                                                }
                                              }
                                            },
                                            initialDropDownValue:
                                                'Sélectionnez un pays',
                                            initialDropDownList: [
                                              'Sélectionnez un pays',
                                              // ? datas integration
                                              for (var pays in snapshot.data!)
                                                pays.libelle,
                                            ],
                                            prefixPadding: 10,
                                            prefixIcon: Image.asset(
                                              'assets/img/icons/countries.png',
                                              fit: BoxFit.contain,
                                              width: 15,
                                              height: 15,
                                              color: Color.fromRGBO(
                                                  60, 141, 188, 1),
                                            ),
                                            textColor:
                                                Color.fromRGBO(60, 141, 188, 1),
                                            fillColor: Color.fromRGBO(
                                                60, 141, 188, 0.15),
                                            borderRadius: Radius.circular(10),
                                            focusBorderColor:
                                                Colors.transparent,
                                            enableBorderColor:
                                                Colors.transparent,
                                          );
                                        }
                                        // ? on wait the combo with data load empty combo
                                        return MyTextFormField(
                                          prefixPadding: 10,
                                          prefixIcon: Image.asset(
                                            'assets/img/icons/countries.png',
                                            fit: BoxFit.contain,
                                            width: 15,
                                            height: 15,
                                            color:
                                                Color.fromRGBO(60, 141, 188, 1),
                                          ),
                                          placeholder: 'Sélectionnez un pays',
                                          textColor:
                                              Color.fromRGBO(60, 141, 188, 1),
                                          placeholderColor:
                                              Color.fromRGBO(60, 141, 188, 1),
                                          fillColor: Color.fromRGBO(
                                              60, 141, 188, 0.15),
                                          borderRadius: Radius.circular(10),
                                          focusBorderColor: Colors.transparent,
                                          enableBorderColor: Colors.transparent,
                                        );
                                      },
                                    )
                                  : Container(),
                            ],
                          ),
                          SizedBox(height: 10),
                          //todo: Geographical address Field
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //todo: Geographical address label
                              MyText(
                                text: 'Adresse géographique',
                                color: Color.fromRGBO(0, 27, 121, 1),
                                fontWeight: FontWeight.bold,
                              ),
                              SizedBox(height: 5),
                              //todo: Geographical address TextFormField
                              MyTextFormField(
                                textEditingController:
                                    fieldControllers['geoAdr'],
                                prefixPadding: 10,
                                prefixIcon: Icon(
                                  Icons.location_city_rounded,
                                  color: Color.fromRGBO(60, 141, 188, 1),
                                ),
                                placeholder: 'Adresse géographique du client',
                                textColor: Color.fromRGBO(60, 141, 188, 1),
                                placeholderColor:
                                    Color.fromRGBO(60, 141, 188, 1),
                                fillColor: Color.fromRGBO(60, 141, 188, 0.15),
                                borderRadius: Radius.circular(10),
                                focusBorderColor: Colors.transparent,
                                enableBorderColor: Colors.transparent,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          //todo: Postal address Field
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //todo: Postal address label
                              MyText(
                                text: 'Boite postale',
                                color: Color.fromRGBO(0, 27, 121, 1),
                                fontWeight: FontWeight.bold,
                              ),
                              SizedBox(height: 5),
                              //todo: Postal address TextFormField
                              MyTextFormField(
                                textEditingController:
                                    fieldControllers['postalAdr'],
                                prefixPadding: 10,
                                prefixIcon: Icon(
                                  Icons.location_history_rounded,
                                  color: Color.fromRGBO(60, 141, 188, 1),
                                ),
                                placeholder:
                                    'Adresse de la boite postale du client',
                                textColor: Color.fromRGBO(60, 141, 188, 1),
                                placeholderColor:
                                    Color.fromRGBO(60, 141, 188, 1),
                                fillColor: Color.fromRGBO(60, 141, 188, 0.15),
                                borderRadius: Radius.circular(10),
                                focusBorderColor: Colors.transparent,
                                enableBorderColor: Colors.transparent,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          //todo: Regime Field
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //todo: Regime label
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  MyText(
                                    text: 'Régime',
                                    color: Color.fromRGBO(0, 27, 121, 1),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  CircleAvatar(
                                    radius: 5,
                                    backgroundColor:
                                        Color.fromRGBO(221, 75, 57, 1),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              //todo: Regime DropDown
                              (ScreenController.actualView != "LoginView")
                                  ? FutureBuilder<List<Regime>>(
                                      future: api.getRegimes(context),
                                      builder:
                                          (regimeComboBoxContext, snapshot) {
                                        if (snapshot.hasData) {
                                          // ? get nations datas from server
                                          return MyComboBox(
                                            validator: (value) {
                                              return value! !=
                                                      'Sélectionnez le régime'
                                                  ? null
                                                  : 'Choisissez un régime';
                                            },
                                            onChanged: (value) {
                                              // ? Iterate all countries to get the selected regime id
                                              for (var regime
                                                  in snapshot.data!) {
                                                if (regime.libelle == value) {
                                                  // if the regime name match with the selected
                                                  fieldControllers['regime'] =
                                                      regime
                                                          .id; // save the new regime selected
                                                  print(
                                                      "Nouveau régime: $value, ${fieldControllers['regime']}, ${regime.id}");

                                                  break;
                                                }
                                              }
                                            },
                                            initialDropDownValue:
                                                'Sélectionnez le régime',
                                            initialDropDownList: [
                                              'Sélectionnez le régime',
                                              // ? datas integration
                                              for (var regime in snapshot.data!)
                                                regime.libelle,
                                            ],
                                            prefixPadding: 10,
                                            prefixIcon: Icon(
                                              Icons.circle_outlined,
                                              color: Color.fromRGBO(
                                                  60, 141, 188, 1),
                                            ),
                                            textColor:
                                                Color.fromRGBO(60, 141, 188, 1),
                                            fillColor: Color.fromRGBO(
                                                60, 141, 188, 0.15),
                                            borderRadius: Radius.circular(10),
                                            focusBorderColor:
                                                Colors.transparent,
                                            enableBorderColor:
                                                Colors.transparent,
                                          );
                                        }
                                        // ? on wait the combo with data load empty combo
                                        return MyTextFormField(
                                          prefixPadding: 10,
                                          prefixIcon: Icon(
                                            Icons.circle_outlined,
                                            color:
                                                Color.fromRGBO(60, 141, 188, 1),
                                          ),
                                          placeholder: 'Sélectionnez un régime',
                                          textColor:
                                              Color.fromRGBO(60, 141, 188, 1),
                                          placeholderColor:
                                              Color.fromRGBO(60, 141, 188, 1),
                                          fillColor: Color.fromRGBO(
                                              60, 141, 188, 0.15),
                                          borderRadius: Radius.circular(10),
                                          focusBorderColor: Colors.transparent,
                                          enableBorderColor: Colors.transparent,
                                        );
                                      },
                                    )
                                  : Container(),
                            ],
                          ),
                          SizedBox(height: 10),
                          //todo: Montant plafond Field
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //todo: Montant plafond label
                              MyText(
                                text: 'Montant plafond',
                                color: Color.fromRGBO(0, 27, 121, 1),
                                fontWeight: FontWeight.bold,
                              ),
                              SizedBox(height: 5),
                              //todo: Montant plafond TextFormField
                              MyTextFormField(
                                textEditingController:
                                    fieldControllers['montantPlafond'],
                                prefixPadding: 10,
                                prefixIcon: Icon(
                                  Icons.attach_money_rounded,
                                  color: Color.fromRGBO(60, 141, 188, 1),
                                ),
                                placeholder: 'Montant plafond du client',
                                textColor: Color.fromRGBO(60, 141, 188, 1),
                                placeholderColor:
                                    Color.fromRGBO(60, 141, 188, 1),
                                fillColor: Color.fromRGBO(60, 141, 188, 0.15),
                                borderRadius: Radius.circular(10),
                                focusBorderColor: Colors.transparent,
                                enableBorderColor: Colors.transparent,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          //todo: N° Fax Field
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //todo: N° Fax label
                              MyText(
                                text: 'N° Fax',
                                color: Color.fromRGBO(0, 27, 121, 1),
                                fontWeight: FontWeight.bold,
                              ),
                              SizedBox(height: 5),
                              //todo: N° Fax TextFormField
                              MyTextFormField(
                                textEditingController: fieldControllers['fax'],
                                prefixPadding: 10,
                                prefixIcon: Icon(
                                  Icons.phone_rounded,
                                  color: Color.fromRGBO(60, 141, 188, 1),
                                ),
                                placeholder: 'Numéro fax du client',
                                textColor: Color.fromRGBO(60, 141, 188, 1),
                                placeholderColor:
                                    Color.fromRGBO(60, 141, 188, 1),
                                fillColor: Color.fromRGBO(60, 141, 188, 0.15),
                                borderRadius: Radius.circular(10),
                                focusBorderColor: Colors.transparent,
                                enableBorderColor: Colors.transparent,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          //todo: N° Compte contribuable Field
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //todo: N° Compte contribuable label
                              MyText(
                                text: 'N° Compte contribuable',
                                color: Color.fromRGBO(0, 27, 121, 1),
                                fontWeight: FontWeight.bold,
                              ),
                              SizedBox(height: 5),
                              //todo: N° Compte contribuable TextFormField
                              MyTextFormField(
                                textEditingController:
                                    fieldControllers['compteContrib'],
                                prefixPadding: 10,
                                prefixIcon: Icon(
                                  Icons.file_copy_rounded,
                                  color: Color.fromRGBO(60, 141, 188, 1),
                                ),
                                placeholder:
                                    'Numéro du compte contribuable du client',
                                textColor: Color.fromRGBO(60, 141, 188, 1),
                                placeholderColor:
                                    Color.fromRGBO(60, 141, 188, 1),
                                fillColor: Color.fromRGBO(60, 141, 188, 0.15),
                                borderRadius: Radius.circular(10),
                                focusBorderColor: Colors.transparent,
                                enableBorderColor: Colors.transparent,
                              ),
                            ],
                          ),
                        ],
                      );
                    } else {
                      functions.showWarningDialog(
                        context: context,
                        message: "Choisissez d'abord un client",
                      );
                    }
                  },
                  icon: Icon(
                    Icons.edit_rounded,
                    color: Color.fromRGBO(0, 27, 121, 1),
                    size: 30,
                  ),
                ),
                label: 'Modifier',
              ),
              BottomNavigationBarItem(
                backgroundColor: Color.fromRGBO(60, 141, 188, 0.15),
                icon: IconButton(
                  onPressed: () {
                    if (Client.client != null) {
                      // ? Show confirm dialog
                      functions.showConfirmationDialog(
                        context: context,
                        message: 'Voulez-vous vraiment supprimer le client : ' +
                            Client.client!.nom +
                            ' ?',
                        onValidate: () async {
                          // ? sending delete request to API
                          Client clientToDelete = Client.client!;
                          final Map<String, dynamic> deleteClientResponse =
                              await api.deleteClient(
                            client: clientToDelete,
                          );
                          // ? check the server response
                          if (deleteClientResponse['msg'] ==
                              'Opération effectuée avec succès.') {
                            // ? In Success case
                            Navigator.of(context).pop();
                            Client.client = null;
                            functions.showSuccessDialog(
                              context: context,
                              message: 'Le client : ' +
                                  clientToDelete.nom +
                                  ' a bien été supprimé !',
                            );
                          } else {
                            // ? In Error case
                            Navigator.of(context).pop();
                            functions.showErrorDialog(
                              context: context,
                              message: "Une erreur s'est produite",
                            );
                          }
                          // ? Refresh client list
                          setState(() {});
                        },
                      );
                    } else {
                      functions.showWarningDialog(
                        context: context,
                        message: "Choisissez d'abord un client",
                      );
                    }
                  },
                  icon: Icon(
                    Icons.delete_outline_rounded,
                    color: Color.fromRGBO(187, 0, 0, 1),
                    size: 30,
                  ),
                ),
                label: 'Supprimer',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
