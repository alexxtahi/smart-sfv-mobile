import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smartsfv/functions.dart' as functions;
import 'package:smartsfv/models/User.dart';

class Api {
  // todo: Properties
  late http.Response response;
  bool requestSuccess = false;
  late String url;

  // ! App context methods
  // todo: get user datas method
  Future getUserData(BuildContext context) async {
    //this.url = 'http://localhost:8000/api/getusers'; // set url
    this.url = 'http://192.168.1.16:8000/api/getusers'; // set url
    //this.url = 'https://jsonplaceholder.typicode.com/users'; // JSON placeholder url
    try {
      this.response = await http.get(Uri.parse(url)); // getting datas from url
      print('le lien est: $url');

      if (this.response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        this.requestSuccess = true;
        print(this.response.body);
        // show success snack bar
        functions.successSnackbar(
          context: context,
          message: "Récupération des données réussie",
        );
        //return models.Food.fromJson(jsonDecode(this.response.body));
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        this.requestSuccess = false;
        // show error snack bar
        functions.errorSnackbar(
          context: context,
          message: "Echec de récupération des données",
        );
        throw Exception('Failed to load user datas');
      }
    } catch (error) {
      for (var i = 1; i <= 5; i++) print(error);
    }
  }

  // todo: verify login method
  Future verifyLogin(BuildContext context) async {
    this.url = 'http://192.168.1.16:8000/api/getlogin'; // set url
    try {
      this.response = await http.get(Uri.parse(url)); // getting datas from url
      //print('le lien est: $url'); // ! debug
      // ? Http response status code
      if (this.response.statusCode == 200) {
        // 200 is the success response
        this.requestSuccess = true;
        // ? Getting login informations of all users from the server
        Map<String, dynamic> users = jsonDecode(this.response.body)['data'][0];
        User databaseUser = User.fromJson(users);
        print(
            "Utilisateur dans la base de données: ${databaseUser.login}, ${databaseUser.name}, ${databaseUser.role}"); // ! debug
        // show success snack bar
        functions.successSnackbar(
          context: context,
          message: "Utilisateur: ${databaseUser.login}",
        );
        //return models.Food.fromJson(jsonDecode(this.response.body));
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        this.requestSuccess = false;
        // show error snack bar
        functions.errorSnackbar(
          context: context,
          message: "Echec de récupération des données",
        );
        throw Exception('Failed to load user datas');
      }
    } catch (error) {
      for (var i = 1; i <= 5; i++) print(error);
    }
  }

  // todo: verify login method
  Future verifyLoginRequest(
      BuildContext context, String login, String password) async {
    this.url = 'http://192.168.1.16:8000/api/getlogin'; // set url
    try {
      this.response = await http.post(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
        },
        body: {
          'login': login,
          'password': password,
        },
      );
      functions.showMessageToSnackbar(
          context: context,
          message: "Envoi des identifiants au server éffectué !");
      final responseJson = json.decode(json.encode(this.response.body));
      print("Réponse du server: $responseJson");
    } catch (error) {
      for (var i = 1; i <= 5; i++) print(error);
      functions.errorSnackbar(
          context: context,
          message: "Envoi des identifiants au server éffectué !");
    }
  }

  // ! End app context methods

  // todo: get data method
  Future getData() async {
    this.url = 'http://192.168.138.11:8000/foods'; // set url
    this.response = await http.get(Uri.parse(url)); // getting datas from url
    print('le lien est: $url');

    if (this.response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      this.requestSuccess = true;
      print(this.response);
      //return models.Food.fromJson(jsonDecode(this.response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      this.requestSuccess = false;
      throw Exception('Failed to load Food');
    }
  }

  // todo: post data method
  void postData(String title, String filename) async {
    /*
    ! Best function !!!
    * This function is use to send data from the flutter app to an API
    * Add the datas you want to send in the 'body' with key and value.
    */
    this.url = 'http://192.168.138.11:8000/foods'; // set url
    final response = await http.post(
      Uri.parse(this.url),
      //headers: {AuthUtils.AUTH_HEADER: _authToken},
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/x-www-form-urlencoded',
        'Charset': 'utf-8',
      },
      body: {
        'title': title,
        'filename': filename,
        //'image': image != null ? base64Encode(image.readAsBytesSync()) : '',
      },
    );

    final responseJson = json.decode(json.encode(response.body));

    print("Réponse du server: $responseJson");
  }
}

Api api = new Api();
