import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/functions.dart' as functions;
import 'package:smartsfv/models/Article.dart';
import 'package:smartsfv/models/Banque.dart';
import 'package:smartsfv/models/Cache.dart';
import 'package:smartsfv/models/Caisse.dart';
import 'package:smartsfv/models/Category.dart';
import 'package:smartsfv/models/Client.dart';
import 'package:smartsfv/models/Commande.dart';
import 'package:smartsfv/models/Fournisseur.dart';
import 'package:smartsfv/models/Pays.dart';
import 'package:smartsfv/models/Regime.dart';
import 'package:smartsfv/models/SubCategory.dart';
import 'package:smartsfv/models/Tva.dart';
import 'package:smartsfv/models/User.dart';
import 'package:smartsfv/views/screens/login/LoginView.dart';

class Api {
  // todo: Properties
  late http.Response response;
  bool requestSuccess = false;
  String url = '';
  //String host = 'http://192.168.10.11:8000'; // local ip adress
  String host = 'https://smartsfv.smartyacademy.com';
  late Map<String, String> routes;
  //todo: Constructor
  Api() {
    // initialisation of the routes Map
    this.routes = {
      'login': '${this.host}/api/auth/login',
      'logout': '${this.host}/api/auth/logout',
      'getArticles': '${this.host}/api/auth/articles',
      'getBestArticles': '${this.host}/api/auth/articles',
      'getWorstArticles': '${this.host}/api/auth/articles',
      'getArticlesPeremption':
          '${this.host}/api/auth/articles-en-voie-peremption',
      'getArticlesRupture': '${this.host}/api/auth/articles-en-voie-rupture',
      'userinfo': '${this.host}/api/auth/user',
      'getRegimes': '${this.host}/api/auth/regimes',
      'getNations': '${this.host}/api/auth/nations',
      'postClient': '${this.host}/api/auth/client/store',
      'getClients': '${this.host}/api/auth/clients',
      'getBestClients': '${this.host}/api/auth/beste-clients',
      'getDettesClients': '${this.host}/api/auth/beste-clients',
      'getWorstRentabilityClients': '${this.host}/api/auth/beste-clients',
      'putClient': '${this.host}/api/auth/client/update/',
      'deleteClient': '${this.host}/api/auth/clients/delete/',
      'getFournisseurs': '${this.host}/api/auth/fournisseurs',
      'postFournisseur': '${this.host}/api/auth/fournisseur/store',
      'getCommandes': '${this.host}/api/auth/commande-en-cours',
    };
  }

  // ! App context methods
  // todo: get articles method
  Future<List<Article>> getArticles(BuildContext context) async {
    this.url = this.routes['getArticles'].toString(); // set login url
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
        // ? Show success snack bar
        if (ScreenController.actualView == "ArticleView")
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
          for (var article in articleResponse)
            // ? take only article created by the actual user
            Article.fromJson(article), // ! debug
          //if (article['created_by'] == User.id) Article.fromJson(article), // ! production
        ];
        // ? return list of articles
        return articles;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        this.requestSuccess = false;
        // ? Show error snack bar
        if (ScreenController.actualView == "ArticleView")
          functions.errorSnackbar(
            context: context,
            message: "Echec de récupération des articles",
          );
        return <Article>[];
        //throw Exception('Failed to load user datas');
      }
    } catch (error) {
      print(
          'API ERROR: Get Articles Model Error ${error.runtimeType} -> $error');
      if (error is SocketException || error is FormatException)
        functions.socketErrorSnackbar(context: context);

      return <Article>[];
    }
  }

  // todo: get articles en voie de péremption method
  Future<List<Article>> getArticlesPeremption(BuildContext context) async {
    this.url = this.routes['getArticlesPeremption'].toString(); // set login url
    //print(this.url); // ! debug
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
        // ? Show success snack bar
        if (ScreenController.actualView == "HomeView" &&
            ScreenController.reloadDashboard)
          functions.showMessageToSnackbar(
            context: context,
            message: "Articles en voie de péremption chargés !",
            icon: Icon(
              Icons.info_rounded,
              color: Color.fromRGBO(60, 141, 188, 1),
            ),
          );
        // ? create list of articles
        List articleResponse = json.decode(this.response.body)['rows'];
        //print('Liste articles périmés: $articleResponse');
        List<Article> articles = [
          for (var article in articleResponse)
            Article.fromJson(article), // ! debug
          // ? take only article created by the actual user
          //if (article['created_by'] == User.id) Article.fromJson(article), // ! production
        ];
        // ? return list of articles
        return articles;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        this.requestSuccess = false;
        // ? Show error snack bar
        if (ScreenController.actualView == "HomeView")
          functions.errorSnackbar(
            context: context,
            message: "Echec de récupération des articles en voie de péremption",
          );
        return <Article>[];
        //throw Exception('Failed to load user datas');
      }
    } catch (error) {
      print(
          'API ERROR: Get Articles Peremption Model Error ${error.runtimeType} -> $error');
      if (error is SocketException || error is FormatException)
        functions.socketErrorSnackbar(context: context);
      return <Article>[];
    }
  }

  // todo: get articles en voie de péremption method
  Future<List<Article>> getArticlesRupture(BuildContext context) async {
    this.url = this.routes['getArticlesRupture'].toString(); // set login url
    //print(this.url); // ! debug
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
        // ? Show success snack bar
        if (ScreenController.actualView == "HomeView" &&
            ScreenController.reloadDashboard)
          functions.showMessageToSnackbar(
            context: context,
            message: "Articles en voie de rupture chargés !",
            icon: Icon(
              Icons.info_rounded,
              color: Color.fromRGBO(60, 141, 188, 1),
            ),
          );
        // ? create list of articles
        List articleResponse = json.decode(this.response.body)['rows'];
        //print('Liste articles rupture: $articleResponse');
        List<Article> articles = [
          for (var article in articleResponse)
            Article.fromJson(article), // ! debug
          // ? take only article created by the actual user
          //if (article['created_by'] == User.id) Article.fromJson(article), // ! production
        ];
        // ? return list of articles
        return articles;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        this.requestSuccess = false;
        // ? Show error snack bar
        if (ScreenController.actualView == "HomeView")
          functions.errorSnackbar(
            context: context,
            message: "Echec de récupération des articles en voie de rupture",
          );
        return <Article>[];
        //throw Exception('Failed to load user datas');
      }
    } catch (error) {
      print(
          'API ERROR: Get Articles Rupture Model Error ${error.runtimeType} -> $error');
      if (error is SocketException || error is FormatException)
        functions.socketErrorSnackbar(context: context);
      return <Article>[];
    }
  }

  // todo: get articles les plus vendus method
  Future<List<Article>> getBestArticles(BuildContext context) async {
    this.url = this.routes['getBestArticles'].toString(); // set login url
    //print(this.url); // ! debug
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
        // ? Show success snack bar
        if (ScreenController.actualView == "HomeView" &&
            ScreenController.reloadDashboard)
          functions.showMessageToSnackbar(
            context: context,
            message: "Articles les plus vendus chargés !",
            icon: Icon(
              Icons.info_rounded,
              color: Color.fromRGBO(60, 141, 188, 1),
            ),
          );
        // ? create list of articles
        List articleResponse = json.decode(this.response.body)['rows'];
        //print('Liste articles rupture: $articleResponse');
        List<Article> articles = [
          for (var article in articleResponse)
            Article.fromJson(article), // ! debug
          // ? take only article created by the actual user
          //if (article['created_by'] == User.id) Article.fromJson(article), // ! production
        ];
        // ? return list of articles
        return articles;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        this.requestSuccess = false;
        // ? Show error snack bar
        if (ScreenController.actualView == "HomeView")
          functions.errorSnackbar(
            context: context,
            message: "Echec de récupération des articles les plus vendus",
          );
        return <Article>[];
        //throw Exception('Failed to load user datas');
      }
    } catch (error) {
      print(
          'API ERROR: Get Best Articles Model Error ${error.runtimeType} -> $error');
      if (error is SocketException || error is FormatException)
        functions.socketErrorSnackbar(context: context);
      return <Article>[];
    }
  }

  // todo: get articles les moins vendus method
  Future<List<Article>> getWorstArticles(BuildContext context) async {
    this.url = this.routes['getWorstArticles'].toString(); // set login url
    //print(this.url); // ! debug
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
        // ? Show success snack bar
        if (ScreenController.actualView == "HomeView" &&
            ScreenController.reloadDashboard)
          functions.showMessageToSnackbar(
            context: context,
            message: "Articles les moins vendus chargés !",
            icon: Icon(
              Icons.info_rounded,
              color: Color.fromRGBO(60, 141, 188, 1),
            ),
          );
        // ? create list of articles
        List articleResponse = json.decode(this.response.body)['rows'];
        //print('Liste articles rupture: $articleResponse');
        List<Article> articles = [
          for (var article in articleResponse)
            Article.fromJson(article), // ! debug
          // ? take only article created by the actual user
          //if (article['created_by'] == User.id) Article.fromJson(article), // ! production
        ];
        // ? return list of articles
        return articles;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        this.requestSuccess = false;
        // ? Show error snack bar
        if (ScreenController.actualView == "HomeView")
          functions.errorSnackbar(
            context: context,
            message: "Echec de récupération des articles les moins vendus",
          );
        return <Article>[];
        //throw Exception('Failed to load user datas');
      }
    } catch (error) {
      print(
          'API ERROR: Get Best Articles Model Error ${error.runtimeType} -> $error');
      if (error is SocketException || error is FormatException)
        functions.socketErrorSnackbar(context: context);
      return <Article>[];
    }
  }

  // todo: get clients method
  Future<List<Client>> getClients(BuildContext context) async {
    this.url = this.routes['getClients'].toString(); // set login url
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
        // ? Show success snack bar
        if (ScreenController.actualView == "ClientView")
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
          for (var client in clientResponse) Client.fromJson(client), // ! debug
          // ? take only client created by the actual user
          //if (client['created_by'] == User.id) Client.fromJson(client), // ! production
        ];
        // ? return list of clients
        return clients;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        this.requestSuccess = false;
        // ? Show error snack bar
        if (ScreenController.actualView == "ClientView")
          functions.errorSnackbar(
            context: context,
            message: "Echec de récupération des clients",
          );
        return <Client>[];
        //throw Exception('Failed to load user datas');
      }
    } catch (error) {
      print(
          'API ERROR: Get Client Model Error -> ${error.runtimeType} -> $error');
      if (error is SocketException || error is FormatException)
        functions.socketErrorSnackbar(context: context);
      return <Client>[];
    }
  }

  // todo: get meilleurs clients method
  Future<List<Client>> getBestClients(BuildContext context) async {
    this.url = this.routes['getBestClients'].toString(); // set login url
    //print(this.url); // ! debug
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
        // ? Show success snack bar
        if (ScreenController.actualView == "HomeView" &&
            ScreenController.reloadDashboard)
          functions.showMessageToSnackbar(
            context: context,
            message: "Meilleurs clients chargés !",
            icon: Icon(
              Icons.info_rounded,
              color: Color.fromRGBO(60, 141, 188, 1),
            ),
          );
        // ? create list of clients
        List clientResponse = json.decode(this.response.body)['rows'];
        List<Client> clients = [
          for (var client in clientResponse) Client.fromJson(client), // ! debug
          // ? take only client created by the actual user
          //if (client['created_by'] == User.id) Client.fromJson(client), // ! production
        ];
        // ? return list of clients
        return clients;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        this.requestSuccess = false;
        // ? Show error snack bar
        if (ScreenController.actualView == "HomeView")
          functions.errorSnackbar(
            context: context,
            message: "Echec de récupération des meilleurs clients",
          );
        return <Client>[];
        //throw Exception('Failed to load user datas');
      }
    } catch (error) {
      print(
          'API ERROR: Get Best Clients Error -> ${error.runtimeType} -> $error');
      if (error is SocketException || error is FormatException)
        functions.socketErrorSnackbar(context: context);
      return <Client>[];
    }
  }

  // todo: get pires clients method
  Future<List<Client>> getDettesClients(BuildContext context) async {
    this.url = this.routes['getDettesClients'].toString(); // set login url
    //print(this.url); // ! debug
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
        // ? Show success snack bar
        if (ScreenController.actualView == "HomeView" &&
            ScreenController.reloadDashboard)
          functions.showMessageToSnackbar(
            context: context,
            message: "Clients moins rentables chargés !",
            icon: Icon(
              Icons.info_rounded,
              color: Color.fromRGBO(60, 141, 188, 1),
            ),
          );
        // ? create list of clients
        List clientResponse = json.decode(this.response.body)['rows'];
        List<Client> clients = [
          for (var client in clientResponse) Client.fromJson(client), // ! debug
          // ? take only client created by the actual user
          //if (client['created_by'] == User.id) Client.fromJson(client), // ! production
        ];
        // ? return list of clients
        return clients;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        this.requestSuccess = false;
        // ? Show error snack bar
        if (ScreenController.actualView == "HomeView")
          functions.errorSnackbar(
            context: context,
            message: "Echec de récupération des clients les moins rentable",
          );
        return <Client>[];
        //throw Exception('Failed to load user datas');
      }
    } catch (error) {
      print(
          'API ERROR: Get Worst Clients Error -> ${error.runtimeType} -> $error');
      if (error is SocketException || error is FormatException)
        functions.socketErrorSnackbar(context: context);
      return <Client>[];
    }
  }

  // todo: get pires clients method
  Future<List<Client>> getWorstRentabilityClients(BuildContext context) async {
    this.url =
        this.routes['getWorstRentabilityClients'].toString(); // set login url
    //print(this.url); // ! debug
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
        // ? Show success snack bar
        if (ScreenController.actualView == "HomeView" &&
            ScreenController.reloadDashboard)
          functions.showMessageToSnackbar(
            context: context,
            message: "Clients moins rentables chargés !",
            icon: Icon(
              Icons.info_rounded,
              color: Color.fromRGBO(60, 141, 188, 1),
            ),
          );
        // ? create list of clients
        List clientResponse = json.decode(this.response.body)['rows'];
        List<Client> clients = [
          for (var client in clientResponse) Client.fromJson(client), // ! debug
          // ? take only client created by the actual user
          //if (client['created_by'] == User.id) Client.fromJson(client), // ! production
        ];
        // ? return list of clients
        return clients;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        this.requestSuccess = false;
        // ? Show error snack bar
        if (ScreenController.actualView == "HomeView")
          functions.errorSnackbar(
            context: context,
            message: "Echec de récupération des clients les moins rentable",
          );
        return <Client>[];
        //throw Exception('Failed to load user datas');
      }
    } catch (error) {
      print(
          'API ERROR: Get Worst Clients Error -> ${error.runtimeType} -> $error');
      if (error is SocketException || error is FormatException)
        functions.socketErrorSnackbar(context: context);
      return <Client>[];
    }
  }

  // todo: get commandes method
  Future<List<Commande>> getCommandes(BuildContext context) async {
    this.url = this.routes['getCommandes'].toString(); // set login url
    //print(this.url); // ! debug
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
        //print('Réponse du serveur: ' + this.response.body);
        // ? Show success snack bar
        if (ScreenController.actualView == "CommandeView" &&
            ScreenController.reloadDashboard)
          functions.showMessageToSnackbar(
            context: context,
            message: "Commande chargées !",
            icon: Icon(
              Icons.info_rounded,
              color: Color.fromRGBO(60, 141, 188, 1),
            ),
          );
        // ? create list of countries
        List commandesResponse = json.decode(this.response.body)['rows'];
        List<Commande> commandes = [
          for (var commandes in commandesResponse) Commande.fromJson(commandes),
          // ? take only commande created by the actual user
          //if (commande['created_by'] == User.id) Commande.fromJson(commande), // ! production
        ];
        //print('List: $countries'); // ! debug
        // ? return list of countries
        return commandes;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        this.requestSuccess = false;
        // ? Show error snack bar
        if (ScreenController.actualView == "CommandeView")
          functions.errorSnackbar(
            context: context,
            message: "Echec de récupération des commandes",
          );
        return <Commande>[];
        //throw Exception('Failed to load user datas');
      }
    } catch (error) {
      print(
          'API ERROR: Get Commande Model Error -> ${error.runtimeType} -> $error');
      if (error is SocketException || error is FormatException)
        functions.socketErrorSnackbar(context: context);
      return <Commande>[];
    }
  }

  // todo: get pays method
  Future<List<Pays>> getPays(BuildContext context) async {
    this.url = this.routes['getNations'].toString(); // set login url
    //print(this.url); // ! debug
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
        //print('Réponse du serveur: ' + this.response.body);
        // ? Show success snack bar
        if (ScreenController.actualView == "PaysView")
          functions.showMessageToSnackbar(
            context: context,
            message: "Pays chargés !",
            icon: Icon(
              Icons.info_rounded,
              color: Color.fromRGBO(60, 141, 188, 1),
            ),
          );
        // ? create list of countries
        List paysResponse = json.decode(this.response.body)['rows'];
        List<Pays> countries = [
          for (var pays in paysResponse) Pays.fromJson(pays),
        ];
        //print('List: $countries'); // ! debug
        // ? return list of countries
        return countries;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        this.requestSuccess = false;
        // ? Show error snack bar
        if (ScreenController.actualView == "PaysView")
          functions.errorSnackbar(
            context: context,
            message: "Echec de récupération des pays",
          );
        return <Pays>[];
        //throw Exception('Failed to load user datas');
      }
    } catch (error) {
      print(
          'API ERROR: Get Pays Model Error -> ${error.runtimeType} -> $error');
      if (error is SocketException || error is FormatException)
        functions.socketErrorSnackbar(context: context);
      return <Pays>[];
    }
  }

  // todo: get regimes method
  Future<List<Regime>> getRegimes(BuildContext context) async {
    this.url = this.routes['getRegimes'].toString(); // set login url
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
        //print('Réponse du serveur: ' + this.response.body);
        // ? Show success snack bar
        if (ScreenController.actualView == "RegimeView")
          functions.showMessageToSnackbar(
            context: context,
            message: "Régimes chargés !",
            icon: Icon(
              Icons.info_rounded,
              color: Color.fromRGBO(60, 141, 188, 1),
            ),
          );
        // ? create list of régimes
        List regimeResponse = json.decode(this.response.body)['rows'];
        List<Regime> regimes = [
          // ? take only regime created by the actual user
          for (var regime in regimeResponse) Regime.fromJson(regime), // ! debug
          //if (regime['created_by'] == User.id) Regime.fromJson(regime), // ! production
        ];
        //print('List: $régimes'); // ! debug
        // ? return list of régimes
        return regimes;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        this.requestSuccess = false;
        // ? Show error snack bar
        if (ScreenController.actualView == "RegimeView")
          functions.errorSnackbar(
            context: context,
            message: "Echec de récupération des regimes",
          );
        return <Regime>[];
        //throw Exception('Failed to load user datas');
      }
    } catch (error) {
      print(
          'API ERROR: Get Regime Model Error -> ${error.runtimeType} -> $error');
      if (error is SocketException || error is FormatException)
        functions.socketErrorSnackbar(context: context);
      return <Regime>[];
    }
  }

  // todo: get banques method
  Future<List<Banque>> getBanques(BuildContext context) async {
    this.url = this.routes['getBanques'].toString(); // set login url
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
        this.requestSuccess = true;
        //print('Réponse du serveur: ' + this.response.body);
        // ? Show success snack bar
        if (ScreenController.actualView == "BanqueView")
          functions.showMessageToSnackbar(
            context: context,
            message: "Banques chargées !",
            icon: Icon(
              Icons.info_rounded,
              color: Color.fromRGBO(60, 141, 188, 1),
            ),
          );
        // ? create list of countries
        List banqueResponse = json.decode(this.response.body)['rows'];
        List<Banque> banques = [
          // ? take only banque created by the actual user
          for (var banque in banqueResponse) Banque.fromJson(banque), // ! debug
          //if (banque['created_by'] == User.id) Banque.fromJson(banque), // ! production
        ];
        // ? return list of banques
        return banques;
      } else {
        this.requestSuccess = false;
        // ? Show error snack bar
        if (ScreenController.actualView == "BanqueView")
          functions.errorSnackbar(
            context: context,
            message: "Echec de récupération des banques",
          );
        return <Banque>[];
        //throw Exception('Failed to load user datas');
      }
    } catch (error) {
      print(
          'API ERROR: Get Banque Model Error -> ${error.runtimeType} -> $error');
      if (error is SocketException || error is FormatException)
        functions.socketErrorSnackbar(context: context);
      return <Banque>[];
    }
  }

  // todo: get caisses method
  Future<List<Caisse>> getCaisses(BuildContext context) async {
    this.url = this.routes['getCaisses'].toString(); // set login url
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
        this.requestSuccess = true;
        //print('Réponse du serveur: ' + this.response.body);
        // ? Show success snack bar
        if (ScreenController.actualView == "CaisseView")
          functions.showMessageToSnackbar(
            context: context,
            message: "Caisses chargées !",
            icon: Icon(
              Icons.info_rounded,
              color: Color.fromRGBO(60, 141, 188, 1),
            ),
          );
        // ? create list of countries
        List caisseResponse = json.decode(this.response.body)['rows'];
        List<Caisse> caisses = [
          // ? take only caisse created by the actual user
          for (var caisse in caisseResponse) Caisse.fromJson(caisse), // ! debug
          //if (caisse['created_by'] == User.id) Caisse.fromJson(caisse), // ! production
        ];
        // ? return list of caisses
        return caisses;
      } else {
        this.requestSuccess = false;
        // ? Show error snack bar
        if (ScreenController.actualView == "CaisseView")
          functions.errorSnackbar(
            context: context,
            message: "Echec de récupération des caisses",
          );
        return <Caisse>[];
        //throw Exception('Failed to load user datas');
      }
    } catch (error) {
      print(
          'API ERROR: Get Caisse Model Error -> ${error.runtimeType} -> $error');
      if (error is SocketException || error is FormatException)
        functions.socketErrorSnackbar(context: context);
      return <Caisse>[];
    }
  }

  // todo: get taxes method
  Future<List<Tva>> getTvas(BuildContext context) async {
    this.url = this.routes['getTvas'].toString(); // set login url
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
        this.requestSuccess = true;
        //print('Réponse du serveur: ' + this.response.body);
        // ? Show success snack bar
        if (ScreenController.actualView == "TvaView")
          functions.showMessageToSnackbar(
            context: context,
            message: "Taxes chargées !",
            icon: Icon(
              Icons.info_rounded,
              color: Color.fromRGBO(60, 141, 188, 1),
            ),
          );
        // ? create list of taxs
        List tvaResponse = json.decode(this.response.body)['rows'];
        List<Tva> tvas = [
          // ? take only tva created by the actual user
          for (var tva in tvaResponse) Tva.fromJson(tva), // ! debug
          //if (tva['created_by'] == User.id) Tva.fromJson(tva), // ! production
        ];
        // ? return list of taxs
        return tvas;
      } else {
        this.requestSuccess = false;
        // ? Show error snack bar
        if (ScreenController.actualView == "TvaView")
          functions.errorSnackbar(
            context: context,
            message: "Echec de récupération des taxes",
          );
        return <Tva>[];
      }
    } catch (error) {
      print('API ERROR: Get Tva Model Error -> ${error.runtimeType} -> $error');
      if (error is SocketException || error is FormatException)
        functions.socketErrorSnackbar(context: context);
      return <Tva>[];
    }
  }

  // todo: get catégories method
  Future<List<Category>> getCategories(BuildContext context) async {
    this.url = this.routes['getCategories'].toString(); // set login url
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
        this.requestSuccess = true;
        //print('Réponse du serveur: ' + this.response.body);
        // ? Show success snack bar
        if (ScreenController.actualView == "CategoryView")
          functions.showMessageToSnackbar(
            context: context,
            message: "Catégories chargées !",
            icon: Icon(
              Icons.info_rounded,
              color: Color.fromRGBO(60, 141, 188, 1),
            ),
          );
        // ? create list of taxs
        List categorieResponse = json.decode(this.response.body)['rows'];
        List<Category> categories = [
          // ? take only categorie created by the actual user
          for (var categorie in categorieResponse)
            Category.fromJson(categorie), // ! debug
          //if (categorie['created_by'] == User.id) Category.fromJson(categorie), // ! production
        ];
        // ? return list of categories
        return categories;
      } else {
        this.requestSuccess = false;
        // ? Show error snack bar
        if (ScreenController.actualView == "CategoryView")
          functions.errorSnackbar(
            context: context,
            message: "Echec de récupération des catégories",
          );
        return <Category>[];
      }
    } catch (error) {
      print(
          'API ERROR: Get Category Model Error -> ${error.runtimeType} -> $error');
      if (error is SocketException || error is FormatException)
        functions.socketErrorSnackbar(context: context);
      return <Category>[];
    }
  }

  // todo: get sous catégories method
  Future<List<SubCategory>> getSubCategories(BuildContext context) async {
    this.url = this.routes['getSubCategories'].toString(); // set login url
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
        this.requestSuccess = true;
        //print('Réponse du serveur: ' + this.response.body);
        // ? Show success snack bar
        if (ScreenController.actualView == "SubCategoryView")
          functions.showMessageToSnackbar(
            context: context,
            message: "Sous catégories chargées !",
            icon: Icon(
              Icons.info_rounded,
              color: Color.fromRGBO(60, 141, 188, 1),
            ),
          );
        // ? create list of taxs
        List subCategorieResponse = json.decode(this.response.body)['rows'];
        List<SubCategory> subCategories = [
          // ? take only subCategorie created by the actual user
          for (var subCategorie in subCategorieResponse)
            SubCategory.fromJson(subCategorie), // ! debug
          //if (subCategorie['created_by'] == User.id) SubCategory.fromJson(subCategorie), // ! production
        ];
        // ? return list of sous categories
        return subCategories;
      } else {
        this.requestSuccess = false;
        // ? Show error snack bar
        if (ScreenController.actualView == "SubCategoryView")
          functions.errorSnackbar(
            context: context,
            message: "Echec de récupération des sous catégories",
          );
        return <SubCategory>[];
      }
    } catch (error) {
      print(
          'API ERROR: SubCategory Model Error -> ${error.runtimeType} -> $error');
      if (error is SocketException || error is FormatException)
        functions.socketErrorSnackbar(context: context);
      return <SubCategory>[];
    }
  }

  // todo: get dashboard stats method
  Future<Map<String, int>> getDashboardStats(BuildContext context) async {
    Map<String, int> dashboardDatas = {};
    try {
      // ? Get user dashboard datas
      List<Client> clients = await getClients(context);
      List<Article> articles = await getArticles(context);
      List<Fournisseur> fournisseurs = await getFournisseurs(context);
      List<Commande> commandes = await getCommandes(context);
      //List<Depot> depots = await getDepots(context);
      // ? Put the number of this datas in the dashboard stats list
      dashboardDatas['getClients'] = clients.length;
      dashboardDatas['getArticles'] = articles.length;
      dashboardDatas['getFournisseurs'] = fournisseurs.length;
      dashboardDatas['getCommandes'] = commandes.length;
      // ? Try to put datas in the cache
      try {
        // load SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        // Put datas into the cache
        bool isClientsSave = await prefs.setInt(
            'getClients', dashboardDatas['getClients']!.toInt());
        bool isArticlesSave = await prefs.setInt(
            'getArticles', dashboardDatas['getArticles']!.toInt());
        bool isFournisseursSave = await prefs.setInt(
            'getFournisseurs', dashboardDatas['getFournisseurs']!.toInt());
        bool isCommandesSave = await prefs.setInt(
            'getCommandes', dashboardDatas['getCommandes']!.toInt());
        // print success message
        if (isClientsSave &&
            isArticlesSave &&
            isFournisseursSave &&
            isCommandesSave) {
          print("[SUCCESS] Datas has been saved to the phone cache !");
          // ? Get cache datas
          Map<String, int> cacheDatas = {
            'getClients': prefs.getInt('getClients')!,
            'getArticles': prefs.getInt('getArticles')!,
            'getFournisseurs': prefs.getInt('getFournisseurs')!,
            'getCommandes': prefs.getInt('getCommandes')!,
          };
          // ? Set cache datas into the dashboards Map when it is empty
          if (dashboardDatas.isEmpty) dashboardDatas = cacheDatas;
          // ? Put key if not exist
          for (var key in cacheDatas.keys) {
            dashboardDatas.putIfAbsent(key, () => cacheDatas[key]!);
          }
          // ? Put in the on launched cache class
          Cache.clients = cacheDatas['getClients'];
          Cache.articles = cacheDatas['getArticles'];
          Cache.fournisseurs = cacheDatas['getFournisseurs'];
          Cache.commandes = cacheDatas['getCommandes'];
          Cache.isCached = true;
          // ! debug
          print("TEST getClients -> ${Cache.clients}");
          print("TEST getArticles -> ${Cache.articles}");
          print("TEST getFournisseurs -> ${Cache.fournisseurs}");
          print("TEST getCommandes -> ${Cache.commandes}");
          // ! end debug
          ScreenController.reloadDashboard = false;
        } else {
          // or error message
          print("[ERROR] Failed to save data to the phone cache !");
          ScreenController.reloadDashboard = false;
        }
      } catch (e) {}
      // ? Show success snack bar
      if (ScreenController.reloadDashboard) {
        if (ScreenController.actualView == "HomeView")
          functions.showMessageToSnackbar(
            context: context,
            message: "Tableau de bord actualisé !",
            icon: Icon(
              Icons.info_rounded,
              color: Color.fromRGBO(60, 141, 188, 1),
            ),
          );
        ScreenController.reloadDashboard = false;
      }
    } catch (error) {
      print('API ERROR: Dashboard Error -> ${error.runtimeType} -> $error');
      // ? Get Socket errors
      if (error is SocketException || error is FormatException) {
        // ? Show internet error snack bar
        if (ScreenController.actualView == "HomeView")
          functions.socketErrorSnackbar(context: context);
      } else {
        // ? Get all others errors
        // ? Show warning snack bar
        if (ScreenController.actualView == "HomeView")
          functions.socketErrorSnackbar(context: context);
      }
      ScreenController.reloadDashboard = false;
    }
    ScreenController.reloadDashboard = false;
    // ? Return dashboard statistics
    return dashboardDatas;
  }

  // todo: get fournisseurs method
  Future<List<Fournisseur>> getFournisseurs(BuildContext context) async {
    this.url =
        this.routes['getFournisseurs'].toString(); // set get fournisseurs url
    /*SharedPreferences prefs =
        await SharedPreferences.getInstance(); // load SharedPreferences
    String? token = prefs.getString('access_token');*/
    //print('get articles token: ' + User.token);
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
        // ? Show success snack bar
        if (ScreenController.actualView == "ProviderView")
          functions.showMessageToSnackbar(
            context: context,
            message: "Fournisseurs chargés !",
            icon: Icon(
              Icons.info_rounded,
              color: Color.fromRGBO(221, 75, 57, 1),
            ),
          );
        // ? create list of fournisseurs
        List fournisseurResponse = json.decode(this.response.body)['rows'];
        List<Fournisseur> fournisseurs = [
          for (var fournisseur in fournisseurResponse)
            Fournisseur.fromJson(fournisseur),
          // ? take only fournisseur created by the actual user
          //if (fournisseur['created_by'] == User.id) Fournisseur.fromJson(fournisseur),
        ];
        // ? return list of fournisseurs
        return fournisseurs;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        this.requestSuccess = false;
        // ? Show error snack bar
        if (ScreenController.actualView == "ProviderView")
          functions.errorSnackbar(
            context: context,
            message: "Echec de récupération des fournisseurs",
          );
        return <Fournisseur>[];
        //throw Exception('Failed to load user datas');
      }
    } catch (error) {
      print(
          'API ERROR: Get Fournisseur Model Error -> ${error.runtimeType} -> $error');
      if (error is SocketException || error is FormatException)
        functions.socketErrorSnackbar(context: context);
      return <Fournisseur>[];
    }
  }

  // todo: get user info method
  Future<Map<String, dynamic>> getUserInfo(BuildContext context) async {
    this.url = this.routes['userinfo'].toString(); // set login url
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
        // ? create list for the user datas
        Map<String, dynamic> userInfos = json.decode(this.response.body);
        // ? Get user password from cache in the null case
        if (userInfos['password'] == null || userInfos['password'] == 'null') {
          // load SharedPreferences and get last login password
          SharedPreferences prefs = await SharedPreferences.getInstance();
          userInfos['password'] = prefs.getString('password');
        }
        // ? return this list
        return userInfos;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        this.requestSuccess = false;
        // show error snack bar
        functions.errorSnackbar(
          context: context,
          message: "Echec de récupération des infos de l'utilisateur",
        );
        return {'msg': 'no data'};
        //throw Exception('Failed to load user datas');
      }
    } catch (error) {
      print(
          'API ERROR: Get User Infos Error -> ${error.runtimeType} -> $error');
      if (error is SocketException || error is FormatException)
        functions.socketErrorSnackbar(context: context);
      // show error snack bar
      functions.errorSnackbar(
        context: context,
        message: "Echec de récupération des infos de l'utilisateur",
      );
      return {'msg': 'no data'};
    }
  }

  // todo: verify login method
  Future<Map<String, dynamic>> verifyLogin(
      BuildContext context, String login, String password,
      {bool remember = false}) async {
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
          'remember': remember.toString(),
        },
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);

      print(responseJson.runtimeType);
      // ? Login success
      if (responseJson['access_token'] != null) {
        // ? get user informations from the server
        Map<String, dynamic> userInfos = await getUserInfo(context);
        responseJson['login'] = login;
        responseJson['password'] = password;
        responseJson['statut_compte'] =
            (userInfos['statut_compte'] == 1) ? true : false;
        responseJson['created_at'] =
            userInfos['created_at']; //.replaceAll('T', ' ');
        responseJson['updated_at'] =
            userInfos['updated_at']; //.replaceAll('T', ' ');
        //print("Réponse du server: $responseJson");
        print("User informations: $userInfos");
        // ? set user informations
        User.create(responseJson);
        // ? Save token to the cache
        // load SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', responseJson['access_token']); // save token
        prefs.setString('tokenExpDate',
            responseJson['expires_at']); // save token expiration date
        prefs.setString('password', password); // save password
        // get password from cache in the null case
        //print('Cache token -> ' + prefs.getString('token')!); // ! debug
        // ? Show success message
        functions.successSnackbar(
          context: context,
          message: responseJson['message'],
        );
        // ? Show loading message
        functions.showMessageToSnackbar(
          context: context,
          message: "Chargement du tableau de bord...",
          icon: CircularProgressIndicator(
            color: Color.fromRGBO(60, 141, 188, 1),
            backgroundColor: Colors.white.withOpacity(0.1),
            strokeWidth: 5,
          ),
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
      print('API ERROR: Login Error -> ${error.runtimeType} -> $error');
      if (error is SocketException || error is FormatException)
        functions.socketErrorSnackbar(context: context);
      return {"access_token": null}; // return to know login state
    }
  }

  // todo: Logout method
  Future<void> logout(BuildContext context) async {
    this.url = this.routes['logout'].toString(); // set login url
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
        // ? Delete user access token
        // load SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        User.token = '';
        prefs.clear();
        prefs.remove('token');
        // ? Return to LoginView
        functions.openPage(context, LoginView(), mode: 'pushReplacement');
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        this.requestSuccess = false;
        // show error snack bar
        functions.errorSnackbar(
          context: context,
          message: "Echec de déconnexion",
        );
      }
    } catch (error) {
      print('API ERROR: Logout Error -> ${error.runtimeType} -> $error');
      if (error is SocketException || error is FormatException)
        functions.socketErrorSnackbar(context: context);
    }
  }

  // todo: post client method
  Future<Map<String, dynamic>> postClient(
    BuildContext context,
    String name,
    String contact,
    String pays,
    String regime, {
    String email = '',
    String geoAdr = '',
    String postalAdr = '',
    String montantPlafond = '',
    String compteContrib = '',
    String fax = '',
  }) async {
    this.url = this.routes['postClient'].toString(); // set client url
    try {
      this.response = await http.post(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: User.token,
        },
        body: {
          'full_name_client': name, // ! required
          'contact_client': contact, // ! required
          'email_client': email,
          'nation_id': pays, // ! required
          'adresse_client': geoAdr,
          'boite_postale_client': postalAdr,
          'plafond_client': montantPlafond,
          'regime_id': regime, // ! required
          'fax_client': fax,
          'compte_contribuable_client': compteContrib,
        },
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print('API ERROR: Post Client Model ${error.runtimeType} -> $error');
      // ? Show error snack bar
      if (ScreenController.actualView == "ClientView") {
        if (error is SocketException || error is FormatException)
          functions.socketErrorSnackbar(context: context);
        else
          functions.errorSnackbar(
            context: context,
            message: "Echec d'enregistrement du client",
          );
      }
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: post provider method
  Future<Map<String, dynamic>> postFournisseur({
    required BuildContext context,
    required Fournisseur fournisseur,
  }) async {
    this.url = this.routes['postFournisseur'].toString(); // set client url
    print('Post Fournisseur: ' + Fournisseur.toMap(fournisseur).toString());
    try {
      this.response = await http.post(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: User.token,
        },
        body: Fournisseur.toMap(fournisseur),
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(
          'API ERROR: Post Fournisseur Model Error -> ${error.runtimeType} -> $error');
      // ? Show error snack bar
      if (ScreenController.actualView == "ProviderView") {
        if (error is SocketException || error is FormatException)
          functions.socketErrorSnackbar(context: context);
        else
          functions.errorSnackbar(
            context: context,
            message: "Echec d'enregistrement du client",
          );
      }
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: post article method
  Future<Map<String, dynamic>> postArticle(
    BuildContext context, {
    String codeBarre = '',
    String designation = '',
    String fournisseur = '',
    String categorie = '',
    String subCategorie = '',
    String stockMin = '',
    int tva = 0,
    int prixAchatTTC = 0,
    int prixAchatHT = 0,
    int tauxMargeAchat = 0,
    int prixVenteTTC = 0,
    int prixVenteHT = 0,
    int tauxMargeVente = 0,
    String imageArticle = '',
    bool stockable = true,
  }) async {
    this.url = this.routes['postArticle'].toString(); // set client url
    try {
      this.response = await http.post(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: User.token,
        },
        body: {
          'codeBarre': codeBarre,
          'designation': designation,
          'fournisseur': fournisseur,
          'categorie': categorie,
          'subCategorie': subCategorie,
          'stockMin': stockMin,
          'tva': tva,
          'prixAchatTTC': prixAchatTTC,
          'prixAchatHT': prixAchatHT,
          'tauxMargeAchat': tauxMargeAchat,
          'prixVenteTTC': prixVenteTTC,
          'prixVenteHT': prixVenteHT,
          'tauxMargeVente': tauxMargeVente,
          'imageArticle': imageArticle,
          'stockable': stockable.toString(),
        },
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print('API ERROR: Post Article Error -> ${error.runtimeType} -> $error');
      // ? Show error snack bar
      if (ScreenController.actualView == "ArticleView") {
        if (error is SocketException || error is FormatException)
          functions.socketErrorSnackbar(context: context);
        else
          functions.errorSnackbar(
            context: context,
            message: "Echec d'enregistrement de l'article",
          );
      }
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: post bank method
  Future<Map<String, dynamic>> postBank(
      {required BuildContext context, required Banque banque}) async {
    this.url = this.routes['postBank'].toString(); // set client url
    try {
      this.response = await http.post(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: User.token,
        },
        body: Banque.toMap(banque),
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      // ? Show error snack bar
      if (ScreenController.actualView == "BanqueView") {
        if (error is SocketException || error is FormatException)
          functions.socketErrorSnackbar(context: context);
        else
          functions.errorSnackbar(
            context: context,
            message: "Echec d'enregistrement de la banque",
          );
      }
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: post regime method
  Future<Map<String, dynamic>> postRegime(
    BuildContext context,
    String libelle,
  ) async {
    this.url = this.routes['postRegime'].toString(); // set client url
    try {
      this.response = await http.post(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: User.token,
        },
        body: {
          'libelle_regime': libelle,
        },
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      // ? Show error snack bar
      if (ScreenController.actualView == "RegimeView") {
        if (error is SocketException || error is FormatException)
          functions.socketErrorSnackbar(context: context);
        else
          functions.errorSnackbar(
            context: context,
            message: "Echec d'enregistrement du regime",
          );
      }
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: post TVA method
  Future<Map<String, dynamic>> postTva(
    BuildContext context,
    String tva,
  ) async {
    this.url = this.routes['postTva'].toString(); // set client url
    try {
      this.response = await http.post(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: User.token,
        },
        body: {
          'montant_tva': int.parse(tva),
        },
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      // ? Show error snack bar
      if (ScreenController.actualView == "TvaView") {
        if (error is SocketException || error is FormatException)
          functions.socketErrorSnackbar(context: context);
        else
          functions.errorSnackbar(
            context: context,
            message: "Echec d'enregistrement de la taxe",
          );
      }
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: post caisse method
  Future<Map<String, dynamic>> postCaisse({
    required BuildContext context,
    required Caisse caisse,
  }) async {
    this.url = this.routes['postCaisse'].toString(); // set client url
    try {
      this.response = await http.post(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: User.token,
        },
        body: Caisse.toMap(caisse),
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      // ? Show error snack bar
      if (ScreenController.actualView == "CaisseView") {
        if (error is SocketException || error is FormatException)
          functions.socketErrorSnackbar(context: context);
        else
          functions.errorSnackbar(
            context: context,
            message: "Echec d'enregistrement de la caisse",
          );
      }
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: post pays method
  Future<Map<String, dynamic>> postPays({
    required BuildContext context,
    required Pays pays,
  }) async {
    this.url = this.routes['postPays'].toString(); // set client url
    try {
      this.response = await http.post(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: User.token,
        },
        body: Pays.toMap(pays),
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      // ? Show error snack bar
      if (ScreenController.actualView == "PaysView") {
        if (error is SocketException || error is FormatException)
          functions.socketErrorSnackbar(context: context);
        else
          functions.errorSnackbar(
            context: context,
            message: "Echec d'enregistrement du pays",
          );
      }
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: post catégories method
  Future<Map<String, dynamic>> postCategory(
    BuildContext context,
    String libelle,
  ) async {
    this.url = this.routes['postCategory'].toString(); // set client url
    try {
      this.response = await http.post(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: User.token,
        },
        body: {
          'libelle_categorie': libelle,
        },
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      // ? Show error snack bar
      if (ScreenController.actualView == "CategoryView") {
        if (error is SocketException || error is FormatException)
          functions.socketErrorSnackbar(context: context);
        else
          functions.errorSnackbar(
            context: context,
            message: "Echec d'enregistrement de la catégorie",
          );
      }
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: post sous catégorie method
  Future<Map<String, dynamic>> postSubCategory(
    BuildContext context,
    String libelle,
    int categorie,
  ) async {
    this.url = this.routes['postSubCategory'].toString(); // set client url
    try {
      this.response = await http.post(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: User.token,
        },
        body: {
          'libelle_sous_categorie': libelle,
          'categorie_id': categorie,
        },
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      // ? Show error snack bar
      if (ScreenController.actualView == "SubCategoryView") {
        if (error is SocketException || error is FormatException)
          functions.socketErrorSnackbar(context: context);
        else
          functions.errorSnackbar(
            context: context,
            message: "Echec d'enregistrement de la sous catégorie",
          );
      }
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: post moyen payement method
  Future<Map<String, dynamic>> postMoyenPayement(
    BuildContext context,
    String libelle,
  ) async {
    this.url = this.routes['postMoyenPayement'].toString(); // set client url
    try {
      this.response = await http.post(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: User.token,
        },
        body: {
          'libelle_moyen_payement': libelle,
        },
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      // ? Show error snack bar
      if (ScreenController.actualView == "MoyenPayementView") {
        if (error is SocketException || error is FormatException)
          functions.socketErrorSnackbar(context: context);
        else
          functions.errorSnackbar(
            context: context,
            message: "Echec d'enregistrement du moyen de payement",
          );
      }
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: post rayon method
  Future<Map<String, dynamic>> postRayon(
    BuildContext context,
    String libelle,
  ) async {
    this.url = this.routes['postRayon'].toString(); // set client url
    try {
      this.response = await http.post(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: User.token,
        },
        body: {
          'libelle_rayon': libelle,
        },
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      // ? Show error snack bar
      if (ScreenController.actualView == "RayonView") {
        if (error is SocketException || error is FormatException)
          functions.socketErrorSnackbar(context: context);
        else
          functions.errorSnackbar(
            context: context,
            message: "Echec d'enregistrement du rayon",
          );
      }
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: post rangee method
  Future<Map<String, dynamic>> postRangee(
    BuildContext context,
    String libelle,
  ) async {
    this.url = this.routes['postRangee'].toString(); // set client url
    try {
      this.response = await http.post(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: User.token,
        },
        body: {
          'libelle_rangee': libelle,
        },
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      // ? Show error snack bar
      if (ScreenController.actualView == "RangeeView") {
        if (error is SocketException || error is FormatException)
          functions.socketErrorSnackbar(context: context);
        else
          functions.errorSnackbar(
            context: context,
            message: "Echec d'enregistrement de la rangée",
          );
      }
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: post casier method
  Future<Map<String, dynamic>> postCasier(
    BuildContext context,
    String libelle,
  ) async {
    this.url = this.routes['postCasier'].toString(); // set client url
    try {
      this.response = await http.post(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: User.token,
        },
        body: {
          'libelle_casier': libelle,
        },
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      // ? Show error snack bar
      if (ScreenController.actualView == "CasierView") {
        if (error is SocketException || error is FormatException)
          functions.socketErrorSnackbar(context: context);
        else
          functions.errorSnackbar(
            context: context,
            message: "Echec d'enregistrement du casier",
          );
      }
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: post unité method
  Future<Map<String, dynamic>> postUnite(
    BuildContext context,
    String libelle,
    int quantite,
  ) async {
    this.url = this.routes['postUnite'].toString(); // set client url
    try {
      this.response = await http.post(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: User.token,
        },
        body: {
          'libelle_unite': libelle,
          'quantite_lot': quantite,
        },
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      // ? Show error snack bar
      if (ScreenController.actualView == "UniteView") {
        if (error is SocketException || error is FormatException)
          functions.socketErrorSnackbar(context: context);
        else
          functions.errorSnackbar(
            context: context,
            message: "Echec d'enregistrement de l'unité",
          );
      }
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: post taille method
  Future<Map<String, dynamic>> postTaille(
    BuildContext context,
    String libelle,
  ) async {
    this.url = this.routes['postTaille'].toString(); // set client url
    try {
      this.response = await http.post(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: User.token,
        },
        body: {
          'libelle_taille': libelle,
        },
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      // ? Show error snack bar
      if (ScreenController.actualView == "TailleView") {
        if (error is SocketException || error is FormatException)
          functions.socketErrorSnackbar(context: context);
        else
          functions.errorSnackbar(
            context: context,
            message: "Echec d'enregistrement de la taille",
          );
      }
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: post divers method
  Future<Map<String, dynamic>> postDivers(
    BuildContext context,
    String libelle,
  ) async {
    this.url = this.routes['postDivers'].toString(); // set client url
    try {
      this.response = await http.post(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: User.token,
        },
        body: {
          'libelle_divers': libelle,
        },
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      // ? Show error snack bar
      if (ScreenController.actualView == "DiversView") {
        if (error is SocketException || error is FormatException)
          functions.socketErrorSnackbar(context: context);
        else
          functions.errorSnackbar(
            context: context,
            message: "Echec d'enregistrement du divers",
          );
      }
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: post catégorie dépense method
  Future<Map<String, dynamic>> postCategoryDepense(
    BuildContext context,
    String libelle,
  ) async {
    this.url = this.routes['postCategoryDepense'].toString(); // set client url
    try {
      this.response = await http.post(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: User.token,
        },
        body: {
          'libelle_categorie_depense': libelle,
        },
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      // ? Show error snack bar
      if (ScreenController.actualView == "CategoryDepenseView") {
        if (error is SocketException || error is FormatException)
          functions.socketErrorSnackbar(context: context);
        else
          functions.errorSnackbar(
            context: context,
            message: "Echec d'enregistrement de la catégorie dépense",
          );
      }
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // ! End app context methods
}
