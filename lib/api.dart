import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartsfv/functions.dart' as functions;
import 'package:smartsfv/models/Article.dart';
import 'package:smartsfv/models/Client.dart';
import 'package:smartsfv/models/User.dart';

class Api {
  // todo: Properties
  late http.Response response;
  bool requestSuccess = false;
  String url = '';
  String host = '192.168.1.10:8000';
  late Map<String, String> routes;
  //todo: Constructor
  Api() {
    // initialisation of the routes Map
    this.routes = {
      'login': 'http://${this.host}/api/auth/login',
      'getArticles': 'http://${this.host}/api/auth/articles',
      'userinfo': 'http://${this.host}/api/auth/user',
      'logout': 'http://${this.host}/api/auth/logout',
      'getRegimes': 'http://${this.host}/api/auth/regimes',
      'getNations': 'http://${this.host}/api/auth/nations',
      'postClient': 'http://${this.host}/api/auth/client/store',
      'getClients': 'http://${this.host}/api/auth/clients',
      'putClient': 'http://${this.host}/api/auth/client/update/',
      'deleteClient': 'http://${this.host}/api/auth/clients/delete/',
    };
  }

  // ! App context methods
  // todo: get articles method
  Future<List<Article>> getArticles(BuildContext context) async {
    this.url = this.routes['getArticles'].toString(); // set login url
    /*SharedPreferences prefs =
        await SharedPreferences.getInstance(); // load SharedPreferences
    String? token = prefs.getString('access_token');*/
    print('get articles token: ' + User.token);
    try {
      // ? getting datas from url
      this.response = await http.get(
        Uri.parse(this.url),
        headers: {
          // pass access token into the header
          HttpHeaders.authorizationHeader: User.token,
        },
      );
      // ? Check the response status code
      if (this.response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        this.requestSuccess = true;
        //print(this.response.body);
        // show success snack bar
        functions.showMessageToSnackbar(
          context: context,
          message: "Articles chargés !",
          icon: Icon(
            Icons.info_rounded,
            color: Color.fromRGBO(231, 57, 0, 1),
          ),
        );
        // ? create list of articles
        List articleResponse = json.decode(this.response.body)['rows'];
        List<Article> articles = [
          for (var article in articleResponse) Article.fromJson(article),
        ];
        // ? return list of articles
        return articles;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        this.requestSuccess = false;
        // show error snack bar
        functions.errorSnackbar(
          context: context,
          message: "Echec de récupération des articles",
        );
        return <Article>[];
        //throw Exception('Failed to load user datas');
      }
    } catch (error) {
      for (var i = 1; i <= 5; i++) print(error);
      return <Article>[];
    }
  }

  // todo: get articles method
  Future<List<Client>> getClients(BuildContext context) async {
    this.url = this.routes['getClients'].toString(); // set login url
    /*SharedPreferences prefs =
        await SharedPreferences.getInstance(); // load SharedPreferences
    String? token = prefs.getString('access_token');*/
    //print('get clients token: ' + User.token);
    try {
      // ? getting datas from url
      this.response = await http.get(
        Uri.parse(this.url),
        headers: {
          // pass access token into the header
          HttpHeaders.authorizationHeader: User.token,
        },
      );
      // ? Check the response status code
      if (this.response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        this.requestSuccess = true;
        //print(this.response.body);
        // show success snack bar
        functions.showMessageToSnackbar(
          context: context,
          message: "Clients chargés !",
          icon: Icon(
            Icons.info_rounded,
            color: Color.fromRGBO(60, 141, 188, 1),
          ),
        );
        // ? create list of clients
        List clientResponse = json.decode(this.response.body)['rows'];
        List<Client> clients = [
          for (var client in clientResponse) Client.fromJson(client),
        ];
        // ? return list of clients
        return clients;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        this.requestSuccess = false;
        // show error snack bar
        functions.errorSnackbar(
          context: context,
          message: "Echec de récupération des clients",
        );
        return <Client>[];
        //throw Exception('Failed to load user datas');
      }
    } catch (error) {
      for (var i = 1; i <= 5; i++) print(error);
      return <Client>[];
    }
  }

  // todo: verify login method
  Future<Map<String, dynamic>> verifyLogin(
      BuildContext context, String login, String password,
      {String remember = 'false'}) async {
    this.url = this.routes['login'].toString(); // set login url
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
          'remember': remember,
        },
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      //print("Réponse du server: $responseJson");
      //print(responseJson.runtimeType);
      // ? Login success
      if (responseJson['access_token'] != null) {
        // create new user instance and save his token
        /*User user = User.fromJson(jsonDecode(this.response.body));
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', responseJson['access_token']);
        String? token = prefs.getString('access_token');*/
        User.token = responseJson['access_token'];
        print('get token: ' + User.token);
        // show success messag
        functions.successSnackbar(
          context: context,
          message: responseJson['message'],
        );

        return responseJson; // return to know login state
        // ? Login failed
      } else {
        functions.errorSnackbar(
          context: context,
          message: responseJson['message'],
        );
        return responseJson; // return to know lodin state
      }
    } catch (error) {
      for (var i = 1; i <= 5; i++) print(error);
      functions.errorSnackbar(
        context: context,
        message: "Echec d'envoi des identifiants",
      );
      return {"access_token": null}; // return to know login state
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
