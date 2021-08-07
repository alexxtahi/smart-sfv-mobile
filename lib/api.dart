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
  String url = '';
  final Map<String, String> routes = {
    'login': 'http://192.168.1.8:8000/api/auth/login',
    'getArticles': 'http://192.168.1.8:8000/api/auth/articles',
    'userinfo': 'http://192.168.1.8:8000/api/auth/user',
    'logout': 'http://192.168.1.8:8000/api/auth/logout',
    'getRegimes': 'http://192.168.1.8:8000/api/auth/regimes',
    'getNations': 'http://192.168.1.8:8000/api/auth/nations',
    'postClient': 'http://192.168.1.8:8000/api/auth/client/store',
    'getClients': 'http://192.168.1.8:8000/api/auth/clients',
    'putClient': 'http://192.168.1.8:8000/api/auth/client/update/',
    'delete': 'http://192.168.1.8:8000/api/auth/clients/delete/',
  };

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
  Future<String> verifyLogin(
      BuildContext context, String login, String password) async {
    this.url = this.routes['login'].toString(); // set url
    try {
      this.response = await http.post(
        Uri.parse(this.url),
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
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      // ? Login success
      if (responseJson['access_token'] != null) {
        functions.successSnackbar(
          context: context,
          message: responseJson['message'],
        );
        return 'login-success'; // return to know lodin state
        // ? Login failed
      } else {
        functions.errorSnackbar(
          context: context,
          message: responseJson['message'],
        );
        return 'login-failed'; // return to know lodin state
      }
    } catch (error) {
      for (var i = 1; i <= 5; i++) print(error);
      functions.errorSnackbar(
        context: context,
        message: "Echec d'envoi des identifiants",
      );
      return 'login-failed'; // return to know lodin state
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
