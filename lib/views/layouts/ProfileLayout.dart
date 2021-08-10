import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/functions.dart' as functions;
import 'package:smartsfv/models/User.dart';
import 'package:smartsfv/views/components/MyText.dart';
import 'package:smartsfv/views/components/MyTextFormField.dart';
import 'package:smartsfv/views/screens/login/LoginView.dart';
import 'package:smartsfv/views/components/MyOutlinedButton.dart';
import 'package:intl/intl.dart';

class ProfileLayout extends StatefulWidget {
  final SlidingUpPanelController panelController;
  ProfileLayout({
    Key? key,
    required this.panelController,
  }) : super(key: key);

  @override
  ProfileLayoutState createState() => ProfileLayoutState();
}

class ProfileLayoutState extends State<ProfileLayout> {
  bool isPasswordShow = false;
  DateFormat dateFormat = DateFormat('dd-mm-yyyy HH:mm:ss');
  Map<String, dynamic> fieldControllers = {
    'name': TextEditingController(),
    'contact': TextEditingController(),
    'email': TextEditingController(),
    'pays': '',
    'geoAdr': TextEditingController(),
    'postalAdr': TextEditingController(),
    'regimes': '',
    'montantPlafond': TextEditingController(),
    'fax': TextEditingController(),
    'compteContrib': TextEditingController(),
  };
  @override
  void initState() {
    //todo: Hide panel
    widget.panelController.hide();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    precacheImage(
        AssetImage('assets/img/backgrounds/storage-center.jpg'), context);
    precacheImage(
        AssetImage('assets/img/backgrounds/gestion-stock.jpg'), context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    List<double> screenSize = ScreenController.getScreenSize(context);
    return SlidingUpPanelWidget(
      controlHeight: 50.0,
      anchor: 0.5,
      panelController: widget.panelController,
      child: Container(
        width: screenSize[0],
        //margin: EdgeInsets.symmetric(horizontal: 15.0),
        decoration: ShapeDecoration(
          color: Colors.white,
          shadows: [
            BoxShadow(
              blurRadius: 5.0,
              spreadRadius: 2.0,
              color: const Color(0x110000),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //todo: Grap
              Container(
                width: 70,
                height: 10,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 0, 0, 0.17),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              SizedBox(height: 20),
              //todo: Avatar
              CircleAvatar(
                radius: 70,
                backgroundColor: Color.fromRGBO(60, 141, 188, 0.3),
                backgroundImage:
                    AssetImage('assets/img/backgrounds/entrepot.jpg'),
              ),
              SizedBox(height: 15),
              //todo: Username
              MyText(
                text: User.name,
                color: Color.fromRGBO(0, 0, 0, 0.5),
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              SizedBox(height: 5),
              //todo: Role
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Color.fromRGBO(0, 0, 0, 0.5),
                    fontSize: 16,
                  ),
                  children: [
                    TextSpan(
                      text: 'Rôle',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(text: ": "),
                    TextSpan(text: User.role),
                  ],
                ),
              ),
              SizedBox(height: 20),
              //todo: Buttons
              Column(
                children: [
                  //todo: Edit user datas button
                  MyOutlinedButton(
                    text: 'Modifier mes informations',
                    textColor: Color.fromRGBO(60, 141, 188, 1),
                    width: screenSize[0],
                    height: 50,
                    borderRadius: 10,
                    borderColor: Color.fromRGBO(60, 141, 188, 10),
                    onPressed: () {
                      GlobalKey<FormState> formKey = GlobalKey<FormState>();
                      // ? Get actual username
                      TextEditingController nameField = TextEditingController();
                      TextEditingController loginField =
                          TextEditingController();
                      TextEditingController emailField =
                          TextEditingController();
                      TextEditingController contactField =
                          TextEditingController();
                      nameField.text = User.name;
                      loginField.text = User.login;
                      emailField.text = User.email;
                      contactField.text = User.contact;
                      functions.showFormDialog(
                        context,
                        formKey,
                        headerIcon: 'assets/img/icons/account.png',
                        title: 'Modifier mes informations',
                        onValidate: () {
                          if (formKey.currentState!.validate()) {
                            Navigator.of(context).pop();
                          }
                        },
                        formElements: [
                          //todo: Name Field
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //todo: Name label
                              MyText(
                                text: 'Nom complet',
                                color: Color.fromRGBO(0, 27, 121, 1),
                                fontWeight: FontWeight.bold,
                              ),
                              SizedBox(height: 5),
                              //todo: Name TextFormField
                              MyTextFormField(
                                textEditingController: nameField,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Entrez un nom avant de valider';
                                  }
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
                          //todo: Login Field
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //todo: Login label
                              MyText(
                                text: 'Login',
                                color: Color.fromRGBO(0, 27, 121, 1),
                                fontWeight: FontWeight.bold,
                              ),
                              SizedBox(height: 5),
                              //todo: Login TextFormField
                              MyTextFormField(
                                textEditingController: loginField,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Entrez un login avant de valider';
                                  }
                                },
                                prefixPadding: 10,
                                prefixIcon: Image.asset(
                                  'assets/img/icons/key.png',
                                  fit: BoxFit.contain,
                                  width: 15,
                                  height: 15,
                                  color: Color.fromRGBO(60, 141, 188, 1),
                                ),
                                placeholder: 'Login',
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
                          //todo: E-mail Field
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //todo: E-mail label
                              MyText(
                                text: 'E-mail',
                                color: Color.fromRGBO(0, 27, 121, 1),
                                fontWeight: FontWeight.bold,
                              ),
                              SizedBox(height: 5),
                              //todo: E-mail TextFormField
                              MyTextFormField(
                                textEditingController: emailField,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Entrez un email avant de valider';
                                  }
                                },
                                prefixPadding: 10,
                                prefixIcon: Image.asset(
                                  'assets/img/icons/mail.png',
                                  fit: BoxFit.contain,
                                  width: 15,
                                  height: 15,
                                  color: Color.fromRGBO(60, 141, 188, 1),
                                ),
                                placeholder: 'E-mail',
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
                              MyText(
                                text: 'Contact',
                                color: Color.fromRGBO(0, 27, 121, 1),
                                fontWeight: FontWeight.bold,
                              ),
                              SizedBox(height: 5),
                              //todo: Contact TextFormField
                              MyTextFormField(
                                textEditingController: contactField,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Entrez un contact avant de valider';
                                  }
                                },
                                prefixPadding: 10,
                                prefixIcon: Image.asset(
                                  'assets/img/icons/account.png',
                                  fit: BoxFit.contain,
                                  width: 15,
                                  height: 15,
                                  color: Color.fromRGBO(60, 141, 188, 1),
                                ),
                                placeholder: 'Contact',
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
                    },
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //todo: profil button
                      MyOutlinedButton(
                        text: 'Profil',
                        textColor: Color.fromRGBO(60, 141, 188, 1),
                        width: screenSize[0] / 2.27,
                        height: 50,
                        borderRadius: 10,
                        borderColor: Color.fromRGBO(60, 141, 188, 1),
                        backgroundColor: Color.fromRGBO(60, 141, 188, 0.15),
                        onPressed: () {
                          // ? Expand profil panel on pressed
                          widget.panelController.expand();
                        },
                      ),
                      //todo: logout button
                      MyOutlinedButton(
                        text: 'Deconnexion',
                        textColor: Color.fromRGBO(221, 75, 57, 1),
                        width: screenSize[0] / 2.27,
                        height: 50,
                        borderRadius: 10,
                        borderColor: Color.fromRGBO(221, 75, 57, 1),
                        backgroundColor: Color.fromRGBO(221, 75, 57, 0.15),
                        onPressed: () {
                          functions.openPage(
                            context,
                            LoginView(),
                            mode: 'pushReplacement',
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  //todo: User all datas
                  MyText(
                    text: "Informations de l'utilisateur",
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 5),
                  Container(
                    width: screenSize[0] / 2,
                    height: 2.5,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  SizedBox(height: 15),
                  //todo: Name
                  Stack(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    alignment: Alignment.centerRight,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MyText(
                            text: "Nom:",
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(width: 10),
                          MyText(
                            text: User.name,
                            fontSize: 12,
                            //fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      //todo: Edit button
                      InkWell(
                        onTap: () {
                          GlobalKey<FormState> formKey = GlobalKey<FormState>();
                          // ? Get actual username
                          TextEditingController nameField =
                              TextEditingController();
                          nameField.text = User.name;
                          functions.showFormDialog(
                            context,
                            formKey,
                            headerIcon: 'assets/img/icons/account.png',
                            title: 'Modifier le nom',
                            onValidate: () {
                              if (formKey.currentState!.validate()) {
                                Navigator.of(context).pop();
                              }
                            },
                            formElements: [
                              //todo: Name Field
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //todo: Name label
                                  MyText(
                                    text: 'Nom complet',
                                    color: Color.fromRGBO(0, 27, 121, 1),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  SizedBox(height: 5),
                                  //todo: Name TextFormField
                                  MyTextFormField(
                                    textEditingController: nameField,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Entrez un nom avant de valider';
                                      } else if (value == User.name) {
                                        return 'Les noms sont identiques';
                                      } else {
                                        return null;
                                      }
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
                                    fillColor:
                                        Color.fromRGBO(60, 141, 188, 0.15),
                                    borderRadius: Radius.circular(10),
                                    focusBorderColor: Colors.transparent,
                                    enableBorderColor: Colors.transparent,
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                        child: Chip(
                          backgroundColor: Color.fromRGBO(60, 141, 188, 0.15),
                          label: MyText(
                            text: 'Modifier',
                            color: Color.fromRGBO(0, 27, 121, 1),
                          ),
                          avatar: Icon(
                            Icons.edit_outlined,
                            color: Color.fromRGBO(0, 27, 121, 1),
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  //todo: Login
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MyText(
                            text: "Login:",
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(width: 10),
                          MyText(
                            text: User.login,
                            fontSize: 12,
                            //fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      //todo: Edit button
                      InkWell(
                        onTap: () {
                          GlobalKey<FormState> formKey = GlobalKey<FormState>();
                          // ? Get actual username
                          TextEditingController loginField =
                              TextEditingController();
                          loginField.text = User.login;
                          functions.showFormDialog(
                            context,
                            formKey,
                            headerIcon: 'assets/img/icons/account.png',
                            title: 'Modifier le login',
                            onValidate: () {
                              if (formKey.currentState!.validate()) {
                                Navigator.of(context).pop();
                              }
                            },
                            formElements: [
                              //todo: Login Field
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //todo: Login label
                                  MyText(
                                    text: 'Login',
                                    color: Color.fromRGBO(0, 27, 121, 1),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  SizedBox(height: 5),
                                  //todo: Login TextFormField
                                  MyTextFormField(
                                    textEditingController: loginField,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Entrez un login avant de valider';
                                      } else if (value == User.login) {
                                        return 'Les logins sont identiques';
                                      } else {
                                        return null;
                                      }
                                    },
                                    prefixPadding: 10,
                                    prefixIcon: Image.asset(
                                      'assets/img/icons/account.png',
                                      fit: BoxFit.contain,
                                      width: 15,
                                      height: 15,
                                      color: Color.fromRGBO(60, 141, 188, 1),
                                    ),
                                    placeholder: 'Login',
                                    textColor: Color.fromRGBO(60, 141, 188, 1),
                                    placeholderColor:
                                        Color.fromRGBO(60, 141, 188, 1),
                                    fillColor:
                                        Color.fromRGBO(60, 141, 188, 0.15),
                                    borderRadius: Radius.circular(10),
                                    focusBorderColor: Colors.transparent,
                                    enableBorderColor: Colors.transparent,
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                        child: Chip(
                          backgroundColor: Color.fromRGBO(60, 141, 188, 0.15),
                          label: MyText(
                            text: 'Modifier',
                            color: Color.fromRGBO(0, 27, 121, 1),
                          ),
                          avatar: Icon(
                            Icons.edit_outlined,
                            color: Color.fromRGBO(0, 27, 121, 1),
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  //todo: Mot de passe
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MyText(
                            text: "Mot de passe:",
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(width: 10),
                          MyText(
                            text: (isPasswordShow) ? User.password : '••••••••',
                            fontSize: 12,
                            //fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          //todo: Show button
                          InkWell(
                            onTap: () {
                              setState(() {
                                isPasswordShow = !isPasswordShow;
                              });
                            },
                            child: Chip(
                              backgroundColor:
                                  Color.fromRGBO(60, 141, 188, 0.15),
                              label: Icon(
                                (isPasswordShow)
                                    ? Icons.circle
                                    : Icons.panorama_fish_eye,
                                color: Color.fromRGBO(0, 27, 121, 1),
                                size: 20,
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          //todo: Edit button
                          InkWell(
                            child: Chip(
                              backgroundColor:
                                  Color.fromRGBO(60, 141, 188, 0.15),
                              label: Icon(
                                Icons.mode_edit_outline_outlined,
                                color: Color.fromRGBO(0, 27, 121, 1),
                                size: 20,
                              ),
                            ),
                            onTap: () {
                              GlobalKey<FormState> formKey =
                                  GlobalKey<FormState>();
                              // ? Set password controller
                              TextEditingController oldPasswordField =
                                  TextEditingController();
                              TextEditingController newPasswordField =
                                  TextEditingController();
                              //passwordField.text = User.login;
                              functions.showFormDialog(
                                context,
                                formKey,
                                headerIcon: 'assets/img/icons/account.png',
                                title: 'Modifier le mot de passe',
                                onValidate: () {
                                  if (formKey.currentState!.validate()) {
                                    Navigator.of(context).pop();
                                  }
                                },
                                formElements: [
                                  //todo: Mot de passe actuel Field
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //todo: Mot de passe actuel label
                                      MyText(
                                        text: 'Mot de passe actuel',
                                        color: Color.fromRGBO(0, 27, 121, 1),
                                        fontWeight: FontWeight.bold,
                                      ),
                                      SizedBox(height: 5),
                                      //todo: Mot de passe actuel TextFormField
                                      MyTextFormField(
                                        textEditingController: oldPasswordField,
                                        inputType: 'password',
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Entrez le mot de passe actuel';
                                          } else if (value != User.login) {
                                            return 'Ce mot de passe ne correspond pas à celui de votre compte';
                                          } else {
                                            return null;
                                          }
                                        },
                                        prefixPadding: 10,
                                        prefixIcon: Image.asset(
                                          'assets/img/icons/key.png',
                                          fit: BoxFit.contain,
                                          width: 15,
                                          height: 15,
                                          color:
                                              Color.fromRGBO(60, 141, 188, 1),
                                        ),
                                        placeholder: 'Mot de passe actuel',
                                        textColor:
                                            Color.fromRGBO(60, 141, 188, 1),
                                        placeholderColor:
                                            Color.fromRGBO(60, 141, 188, 1),
                                        fillColor:
                                            Color.fromRGBO(60, 141, 188, 0.15),
                                        borderRadius: Radius.circular(10),
                                        focusBorderColor: Colors.transparent,
                                        enableBorderColor: Colors.transparent,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15),
                                  //todo: Nouveau mot de passe Field
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //todo: Nouveau mot de passe label
                                      MyText(
                                        text: 'Nouveau mot de passe',
                                        color: Color.fromRGBO(0, 27, 121, 1),
                                        fontWeight: FontWeight.bold,
                                      ),
                                      SizedBox(height: 5),
                                      //todo: Nouveau mot de passe TextFormField
                                      MyTextFormField(
                                        textEditingController: newPasswordField,
                                        inputType: 'password',
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Entrez un nouveau mot de passe avant de valider';
                                          } else if (value == User.login) {
                                            return 'Les mots de passe sont identiques';
                                          } else {
                                            return null;
                                          }
                                        },
                                        prefixPadding: 10,
                                        prefixIcon: Image.asset(
                                          'assets/img/icons/padlock.png',
                                          fit: BoxFit.contain,
                                          width: 15,
                                          height: 15,
                                          color:
                                              Color.fromRGBO(60, 141, 188, 1),
                                        ),
                                        placeholder: 'Nouveau mot de passe',
                                        textColor:
                                            Color.fromRGBO(60, 141, 188, 1),
                                        placeholderColor:
                                            Color.fromRGBO(60, 141, 188, 1),
                                        fillColor:
                                            Color.fromRGBO(60, 141, 188, 0.15),
                                        borderRadius: Radius.circular(10),
                                        focusBorderColor: Colors.transparent,
                                        enableBorderColor: Colors.transparent,
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  //todo: E-mail
                  Stack(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    alignment: Alignment.centerRight,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MyText(
                            text: "E-mail:",
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(width: 10),
                          MyText(
                            text: User.email,
                            fontSize: 12,
                            //fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      //todo: Edit button
                      InkWell(
                        onTap: () {
                          GlobalKey<FormState> formKey = GlobalKey<FormState>();
                          // ? Get actual username
                          TextEditingController emailField =
                              TextEditingController();
                          emailField.text = User.email;
                          functions.showFormDialog(
                            context,
                            formKey,
                            headerIcon: 'assets/img/icons/account.png',
                            title: "Modifier l'adresse mail",
                            onValidate: () {
                              if (formKey.currentState!.validate()) {
                                Navigator.of(context).pop();
                              }
                            },
                            formElements: [
                              //todo: E-mail Field
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //todo: E-mail label
                                  MyText(
                                    text: 'E-mail',
                                    color: Color.fromRGBO(0, 27, 121, 1),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  SizedBox(height: 5),
                                  //todo: E-mail TextFormField
                                  MyTextFormField(
                                    textEditingController: emailField,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Entrez un email avant de valider';
                                      } else if (value == User.email) {
                                        return 'Les emails sont identiques';
                                      } else {
                                        return null;
                                      }
                                    },
                                    prefixPadding: 10,
                                    prefixIcon: Image.asset(
                                      'assets/img/icons/mail.png',
                                      fit: BoxFit.contain,
                                      width: 15,
                                      height: 15,
                                      color: Color.fromRGBO(60, 141, 188, 1),
                                    ),
                                    placeholder: 'E-mail',
                                    textColor: Color.fromRGBO(60, 141, 188, 1),
                                    placeholderColor:
                                        Color.fromRGBO(60, 141, 188, 1),
                                    fillColor:
                                        Color.fromRGBO(60, 141, 188, 0.15),
                                    borderRadius: Radius.circular(10),
                                    focusBorderColor: Colors.transparent,
                                    enableBorderColor: Colors.transparent,
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                        child: Chip(
                          backgroundColor: Color.fromRGBO(60, 141, 188, 0.15),
                          label: MyText(
                            text: 'Modifier',
                            color: Color.fromRGBO(0, 27, 121, 1),
                          ),
                          avatar: Icon(
                            Icons.edit_outlined,
                            color: Color.fromRGBO(0, 27, 121, 1),
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  //todo: Contact
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MyText(
                            text: "Contact:",
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(width: 10),
                          MyText(
                            text: User.contact,
                            //fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      //todo: Edit button
                      InkWell(
                        onTap: () {
                          GlobalKey<FormState> formKey = GlobalKey<FormState>();
                          // ? Get actual username
                          TextEditingController contactField =
                              TextEditingController();
                          contactField.text = User.contact;
                          functions.showFormDialog(
                            context,
                            formKey,
                            headerIcon: 'assets/img/icons/account.png',
                            title: "Modifier le contact",
                            formElements: [
                              //todo: Contact Field
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //todo: Contact label
                                  MyText(
                                    text: 'Contact',
                                    color: Color.fromRGBO(0, 27, 121, 1),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  SizedBox(height: 5),
                                  //todo: Contact TextFormField
                                  MyTextFormField(
                                    textEditingController: contactField,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Entrez un contact avant de valider';
                                      } else if (value == User.contact) {
                                        return 'Les contacts sont identiques';
                                      } else {
                                        return null;
                                      }
                                    },
                                    prefixPadding: 10,
                                    prefixIcon: Image.asset(
                                      'assets/img/icons/account.png',
                                      fit: BoxFit.contain,
                                      width: 15,
                                      height: 15,
                                      color: Color.fromRGBO(60, 141, 188, 1),
                                    ),
                                    placeholder: 'Contact',
                                    textColor: Color.fromRGBO(60, 141, 188, 1),
                                    placeholderColor:
                                        Color.fromRGBO(60, 141, 188, 1),
                                    fillColor:
                                        Color.fromRGBO(60, 141, 188, 0.15),
                                    borderRadius: Radius.circular(10),
                                    focusBorderColor: Colors.transparent,
                                    enableBorderColor: Colors.transparent,
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                        child: Chip(
                          backgroundColor: Color.fromRGBO(60, 141, 188, 0.15),
                          label: MyText(
                            text: 'Modifier',
                            color: Color.fromRGBO(0, 27, 121, 1),
                          ),
                          avatar: Icon(
                            Icons.edit_outlined,
                            color: Color.fromRGBO(0, 27, 121, 1),
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  //todo: Account state
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      MyText(
                        text: "Etat du compte:",
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(width: 10),
                      MyText(
                        text: (User.state) ? 'Actif' : 'Inactif',
                        color: (User.state) ? Colors.green : Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  //todo: Created at
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      MyText(
                        text: "Inscrit le:",
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: MyText(
                          text: this.dateFormat.format(User.createdAt),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  //todo: Last login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      MyText(
                        text: "Dernière connexion:",
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: MyText(
                          text: this.dateFormat.format(User.lastLogin),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      onTap: () {
        ///Customize the processing logic
        if (widget.panelController.status == SlidingUpPanelStatus.expanded) {
          widget.panelController.anchor();
        } else if (widget.panelController.status ==
            SlidingUpPanelStatus.anchored) {
          widget.panelController.hide();
        }
      }, //Pass a onTap callback to customize the processing logic when user click control bar.
      onStatusChanged: (dragging) {
        // If the dragging direction is dragging down
        if (dragging.index == 1) {
          FocusScope.of(context).requestFocus(FocusNode());
          widget.panelController.hide();
          //print("zaza"); // ! debug
        }
      },
      //enableOnTap: true, //Enable the onTap callback for control bar.
      dragDown: (details) {
        //widget.panelController.hide();
        print('dragDown');
      },
      dragStart: (details) {
        print('dragStart');
      },
      dragCancel: () {
        print('dragCancel');
      },
      dragUpdate: (details) {
        //print('dragUpdate,${panelController.status==SlidingUpPanelStatus.dragging?'dragging':''}');
      },
      dragEnd: (details) {
        print('dragEnd');
      },
    );
  }
}
