import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartsfv/controllers/DrawerLayoutController.dart';
import 'package:smartsfv/controllers/ScreenController.dart';
import 'package:smartsfv/functions.dart' as functions;
import 'package:smartsfv/models/AchatClient.dart';
import 'package:smartsfv/models/Article.dart';
import 'package:smartsfv/models/Auth.dart';
import 'package:smartsfv/models/Banque.dart';
import 'package:smartsfv/models/Cache.dart';
import 'package:smartsfv/models/Caisse.dart';
import 'package:smartsfv/models/Casier.dart';
import 'package:smartsfv/models/Categorie.dart';
import 'package:smartsfv/models/CategorieDepense.dart';
import 'package:smartsfv/models/Client.dart';
import 'package:smartsfv/models/Commande.dart';
import 'package:smartsfv/models/Depot.dart';
import 'package:smartsfv/models/Divers.dart';
import 'package:smartsfv/models/Fournisseur.dart';
import 'package:smartsfv/models/MoyenReglement.dart';
import 'package:smartsfv/models/Pays.dart';
import 'package:smartsfv/models/Rangee.dart';
import 'package:smartsfv/models/Rayon.dart';
import 'package:smartsfv/models/Regime.dart';
import 'package:smartsfv/models/Reglement.dart';
import 'package:smartsfv/models/Research.dart';
import 'package:smartsfv/models/SousCategorie.dart';
import 'package:smartsfv/models/Taille.dart';
import 'package:smartsfv/models/Tva.dart';
import 'package:smartsfv/models/Unite.dart';
import 'package:smartsfv/models/User.dart';
import 'package:smartsfv/views/screens/login/LoginView.dart';

class Api {
  // todo: Properties
  late http.Response response;
  bool requestSuccess = false;
  String url = '';
  String host = 'http://192.168.1.11:8000'; // local ip adress // ! local
  //String host = 'https://smartsfv.smartyacademy.com'; // ! production
  late Map<String, String> routes;
  //todo: Constructor
  Api() {
    // initialisation of the routes Map
    this.routes = {
      // Routes user
      'login': '${this.host}/api/auth/login',
      'logout': '${this.host}/api/auth/logout',
      'userinfo': '${this.host}/api/auth/user',
      'resetPassword': '${this.host}/api/auth/reset-password',
      // Routes articles
      'getArticles': '${this.host}/api/auth/articles',
      'getBestArticles': '${this.host}/api/auth/articles',
      'getWorstArticles': '${this.host}/api/auth/articles',
      'getArticlesPeremption':
          '${this.host}/api/auth/articles-en-voie-peremption',
      'getArticlesRupture': '${this.host}/api/auth/articles-en-voie-rupture',
      'updateArticle': '${this.host}/api/auth/article/update/{id}',
      'deleteArticle': '${this.host}/api/auth/article/delete/{id}',
      // Routes régimes
      'getRegimes': '${this.host}/api/auth/regimes',
      'postRegime': '${this.host}/api/auth/regime/store',
      'updateRegime': '${this.host}/api/auth/regime/update/{id}',
      'deleteRegime': '${this.host}/api/auth/regime/delete/{id}',
      // Routes pays
      'getNations': '${this.host}/api/auth/nations',
      // Routes clients
      'getClients': '${this.host}/api/auth/clients',
      'postClient': '${this.host}/api/auth/client/store',
      'getBestClients': '${this.host}/api/auth/beste-clients',
      'getDettesClients': '${this.host}/api/auth/clients-plus-endettes',
      'getWorstRentabilityClients': '${this.host}/api/auth/beste-clients',
      'updateClient': '${this.host}/api/auth/client/update/{id}',
      'deleteClient': '${this.host}/api/auth/client/delete/{id}',
      'getAchatClients': '${this.host}/api/auth/liste-achats-client/{client}',
      'getReglements': '${this.host}/api/auth/liste-reglements-client/{client}',
      'getArticlesPlusAchetes':
          '${this.host}/api/auth/liste-articles-plus-achetes/{client}',
      // Routes fournisseurs
      'getFournisseurs': '${this.host}/api/auth/fournisseurs',
      'postFournisseur': '${this.host}/api/auth/fournisseur/store',
      'updateFournisseur': '${this.host}/api/auth/fournissuer/update/{id}',
      'deleteFournisseur': '${this.host}/api/auth/fournissuer/delete/{id}',
      // Routes commandes
      'getCommandes': '${this.host}/api/auth/commande-en-cours',
      // Routes banques
      'getBanques': '${this.host}/api/auth/banques',
      'postBanque': '${this.host}/api/auth/banque/store',
      'updateBanque': '${this.host}/api/auth/banque/update/{id}',
      'deleteBanque': '${this.host}/api/auth/banque/delete/{id}',
      // Routes tvas
      'getTvas': '${this.host}/api/auth/tvas',
      'postTva': '${this.host}/api/auth/tva/store',
      'updateTva': '${this.host}/api/auth/tva/update/{id}',
      'deleteTva': '${this.host}/api/auth/tva/delete/{id}',
      // Routes caisses
      'getCaisses': '${this.host}/api/auth/caisses',
      'postCaisse': '${this.host}/api/auth/caisse/store',
      'updateCaisse': '${this.host}/api/auth/caisse/update/{id}',
      'deleteCaisse': '${this.host}/api/auth/caisse/delete/{id}',
      // Routes catégories
      'getCategories': '${this.host}/api/auth/categories',
      'postCategorie': '${this.host}/api/auth/categorie/store',
      'updateCategorie': '${this.host}/api/auth/categorie/update/{id}',
      'deleteCategorie': '${this.host}/api/auth/categorie/delete/{id}',
      // Routes sous catégories
      'getSousCategories': '${this.host}/api/auth/sous-categories',
      'postSousCategorie': '${this.host}/api/auth/sous-categorie/store',
      'updateSousCategorie': '${this.host}/api/auth/sous-categorie/update/{id}',
      'deleteSousCategorie': '${this.host}/api/auth/sous-categorie/delete/{id}',
      // Routes moyens reglement
      'getMoyenReglements': '${this.host}/api/auth/moyen-reglements',
      'postMoyenReglement': '${this.host}/api/auth/moyen-reglement/store',
      'updateMoyenReglement':
          '${this.host}/api/auth/moyen-reglement/update/{id}',
      'deleteMoyenReglement':
          '${this.host}/api/auth/moyen-reglement/delete/{id}',
      // Routes rayons
      'getRayons': '${this.host}/api/auth/rayons',
      'postRayon': '${this.host}/api/auth/rayon/store',
      'updateRayon': '${this.host}/api/auth/rayon/update/{id}',
      'deleteRayon': '${this.host}/api/auth/rayon/delete/{id}',
      // Routes rangées
      'getRangees': '${this.host}/api/auth/rangees',
      'postRangee': '${this.host}/api/auth/rangee/store',
      'updateRangee': '${this.host}/api/auth/rangee/update/{id}',
      'deleteRangee': '${this.host}/api/auth/rangee/delete/{id}',
      // Routes casiers
      'getCasiers': '${this.host}/api/auth/casiers',
      'postCasier': '${this.host}/api/auth/casier/store',
      'updateCasier': '${this.host}/api/auth/casier/update/{id}',
      'deleteCasier': '${this.host}/api/auth/casier/delete/{id}',
      // Routes unités
      'getUnites': '${this.host}/api/auth/unites',
      'postUnite': '${this.host}/api/auth/unite/store',
      'updateUnite': '${this.host}/api/auth/unite/update/{id}',
      'deleteUnite': '${this.host}/api/auth/unite/delete/{id}',
      // Routes tailles
      'getTailles': '${this.host}/api/auth/tailles',
      'postTaille': '${this.host}/api/auth/taille/store',
      'updateTaille': '${this.host}/api/auth/taille/update/{id}',
      'deleteTaille': '${this.host}/api/auth/taille/delete/{id}',
      // Routes divers
      'getDivers': '${this.host}/api/auth/divers',
      'postDivers': '${this.host}/api/auth/divers/store',
      'updateDivers': '${this.host}/api/auth/divers/update/{id}',
      'deleteDivers': '${this.host}/api/auth/divers/delete/{id}',
      // Routes categories dépenses
      'getCategorieDepenses': '${this.host}/api/auth/categorie-depenses',
      'postCategorieDepense': '${this.host}/api/auth/categorie-depense/store',
      'updateCategorieDepense':
          '${this.host}/api/auth/categorie-depense/update/{id}',
      'deleteCategorieDepense':
          '${this.host}/api/auth/categorie-depense/delete/{id}',
      // Routes dépot
      'getDepots': '${this.host}/api/auth/depots',
      'postDepot': '${this.host}/api/auth/depot/store',
      'updateDepot': '${this.host}/api/auth/depot/update/{id}',
      'deleteDepot': '${this.host}/api/auth/depot/delete/{id}',
      // Etats
      'getFactureVentePdf': '${this.host}/api/auth/facture-vente-pdf/{vente}',
      'getReglementPdf':
          '${this.host}/api/auth/liste-reglements-client-pdf/{client}',
      'getArticlesPlusAchetesPdf':
          '${this.host}/api/auth/liste-articles-plus-achetes-pdf/{client}',
    };
  }

  // ! App context methods
  // todo: get articles method
  Future<List<Article>> getArticles(var context) async {
    this.url = this.routes['getArticles'].toString(); // set login url
    try {
      // ? getting datas from url
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.get(
        Uri.parse(this.url),
        headers: {
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
      );
      // ? Check the response status code
      if (this.response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        this.requestSuccess = true;
        print("Articles response -> ${this.response.body}");
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
            // ? filter articles by Research
            if (Research.type == 'Article' &&
                Research.searchBy == 'Par nom' &&
                article['description_article']
                    .toLowerCase()
                    .contains(Research.value.toLowerCase()))
              Article.fromJson(article) // ! Get articles by nom
            else if (Research.type == 'Article' &&
                Research.searchBy == 'Par code barre' &&
                article['code_barre']
                    .toLowerCase()
                    .contains(Research.value.toLowerCase()))
              Article.fromJson(article) // ! Get articles by code barre
            else if (Research.type == 'Article' &&
                Research.type == 'Categorie' &&
                article['categorie']['libelle_categorie']
                    .toLowerCase()
                    .contains(Research.value.toLowerCase()))
              Article.fromJson(article) // ! Get articles by categorie
            else if (Research.type == '')
              Article.fromJson(article) // ! Get all articles

          // ? take all articles
          //Article.fromJson(article), // ! debug
          // ? take only article created by the actual user
          //if (article['created_by'] == User.id)
          //Article.fromJson(article), // ! production
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
  Future<List<Article>> getArticlesPeremption(var context) async {
    this.url = this.routes['getArticlesPeremption'].toString(); // set login url
    //print(this.url); // ! debug
    try {
      // ? getting datas from url
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.get(
        Uri.parse(this.url),
        headers: {
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
      );
      // ? Check the response status code
      if (this.response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        this.requestSuccess = true;
        //print(this.response.body);
        // ? Show success snack bar
        /*if (ScreenController.actualView == "HomeView" &&
            ScreenController.reloadDashboard)
          functions.showMessageToSnackbar(
            context: context,
            message: "Articles en voie de péremption chargés !",
            icon: Icon(
              Icons.info_rounded,
              color: Color.fromRGBO(60, 141, 188, 1),
            ),
          );*/
        // ? create list of articles
        List articleResponse = json.decode(this.response.body)['rows'];
        //print('Liste articles périmés: $articleResponse');
        List<Article> articles = [
          for (var article in articleResponse)
            Article.fromJson(article), // ! debug
          // ? take only article created by the actual user
          //if (article['created_by'] == User.id)
          //Article.fromJson(article), // ! production
        ];
        // ? return list of articles
        return articles;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        this.requestSuccess = false;
        // ? Show error snack bar
        /*if (ScreenController.actualView == "HomeView")
          functions.errorSnackbar(
            context: context,
            message: "Echec de récupération des articles en voie de péremption",
          );*/
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
  Future<List<Article>> getArticlesRupture(var context) async {
    this.url = this.routes['getArticlesRupture'].toString(); // set login url
    //print(this.url); // ! debug
    try {
      // ? getting datas from url
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.get(
        Uri.parse(this.url),
        headers: {
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
      );
      // ? Check the response status code
      if (this.response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        this.requestSuccess = true;
        //print(this.response.body);
        // ? Show success snack bar
        /*if (ScreenController.actualView == "HomeView" &&
            ScreenController.reloadDashboard)
          functions.showMessageToSnackbar(
            context: context,
            message: "Articles en voie de rupture chargés !",
            icon: Icon(
              Icons.info_rounded,
              color: Color.fromRGBO(60, 141, 188, 1),
            ),
          );*/
        // ? create list of articles
        List articleResponse = json.decode(this.response.body)['rows'];
        //print('Liste articles rupture: $articleResponse');
        List<Article> articles = [
          for (var article in articleResponse)
            Article.fromJson(article), // ! debug
          // ? take only article created by the actual user
          //if (article['created_by'] == User.id)
          //Article.fromJson(article), // ! production
        ];
        // ? return list of articles
        return articles;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        this.requestSuccess = false;
        // ? Show error snack bar
        /*if (ScreenController.actualView == "HomeView")
          functions.errorSnackbar(
            context: context,
            message: "Echec de récupération des articles en voie de rupture",
          );*/
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
  Future<List<Article>> getBestArticles(var context) async {
    this.url = this.routes['getBestArticles'].toString(); // set login url
    //print(this.url); // ! debug
    try {
      // ? getting datas from url
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.get(
        Uri.parse(this.url),
        headers: {
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
      );
      // ? Check the response status code
      if (this.response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        this.requestSuccess = true;
        //print(this.response.body);
        // ? Show success snack bar
        /*if (ScreenController.actualView == "HomeView" &&
            ScreenController.reloadDashboard)
          functions.showMessageToSnackbar(
            context: context,
            message: "Articles les plus vendus chargés !",
            icon: Icon(
              Icons.info_rounded,
              color: Color.fromRGBO(60, 141, 188, 1),
            ),
          );*/
        // ? create list of articles
        List articleResponse = json.decode(this.response.body)['rows'];
        //print('Liste articles rupture: $articleResponse');
        List<Article> articles = [
          for (var article in articleResponse)
            Article.fromJson(article), // ! debug
          // ? take only article created by the actual user
          //if (article['created_by'] == User.id)
          //Article.fromJson(article), // ! production
        ];
        // ? return list of articles
        return articles;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        this.requestSuccess = false;
        // ? Show error snack bar
        /*if (ScreenController.actualView == "HomeView")
          functions.errorSnackbar(
            context: context,
            message: "Echec de récupération des articles les plus vendus",
          );*/
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
  Future<List<Article>> getWorstArticles(var context) async {
    this.url = this.routes['getWorstArticles'].toString(); // set login url
    //print(this.url); // ! debug
    try {
      // ? getting datas from url
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.get(
        Uri.parse(this.url),
        headers: {
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
      );
      // ? Check the response status code
      if (this.response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        this.requestSuccess = true;
        //print(this.response.body);
        // ? Show success snack bar
        /*if (ScreenController.actualView == "HomeView" &&
            ScreenController.reloadDashboard)
          functions.showMessageToSnackbar(
            context: context,
            message: "Articles les moins vendus chargés !",
            icon: Icon(
              Icons.info_rounded,
              color: Color.fromRGBO(60, 141, 188, 1),
            ),
          );*/
        // ? create list of articles
        List articleResponse = json.decode(this.response.body)['rows'];
        //print('Liste articles rupture: $articleResponse');
        List<Article> articles = [
          for (var article in articleResponse)
            Article.fromJson(article), // ! debug
          // ? take only article created by the actual user
          //if (article['created_by'] == User.id)
          //Article.fromJson(article), // ! production
        ];
        // ? return list of articles
        return articles;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        this.requestSuccess = false;
        // ? Show error snack bar
        /*if (ScreenController.actualView == "HomeView")
          functions.errorSnackbar(
            context: context,
            message: "Echec de récupération des articles les moins vendus",
          );*/
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
  Future<List<Client>> getClients(var context) async {
    this.url = this.routes['getClients'].toString(); // set login url
    //print('get clients token: ' + Auth.token!);
    try {
      // ? getting datas from url
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.get(
        Uri.parse(this.url),
        headers: {
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
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
          for (var client in clientResponse)
            // ? filter clients by Research
            if (Research.type == 'Client' &&
                client['full_name_client']
                    .toLowerCase()
                    .contains(Research.value.toLowerCase()))
              Client.fromJson(client) // ! Get clients by nom
            else if (Research.type == 'Client' &&
                Research.searchBy == 'Pays' &&
                client['nation']['libelle_nation']
                    .toLowerCase()
                    .contains(Research.value.toLowerCase()))
              Client.fromJson(client) // ! Get clients by pays
            else if (Research.type == '')
              Client.fromJson(client) // ! Get all clients

          // ? take all clients
          //Client.fromJson(client), // ! debug
          // ? take only client created by the actual user
          //if (client['created_by'] == User.id)
          //Client.fromJson(client), // ! production
        ];
        // ? return list of clients
        return clients;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        this.requestSuccess = false;
        // ? Show error snack bar
        /*if (ScreenController.actualView == "ClientView")
          functions.errorSnackbar(
            context: context,
            message: "Echec de récupération des clients",
          );*/
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

  // todo: get clients method
  Future<List<AchatClient>> getAchatClients({required int id}) async {
    this.url = this.routes['getAchatClients'].toString().replaceAll(
          // ? Replace {id} by true value
          '{client}',
          id.toString(),
        ); // set update ur
    //print('get clients token: ' + Auth.token!);
    try {
      // ? getting datas from url
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.get(
        Uri.parse(this.url),
        headers: {
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
      );
      // ? Check the response status code
      if (this.response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        this.requestSuccess = true;
        //print(this.response.body);
        // ? Show success snack bar
        /*
        if (ScreenController.actualView == "AchatClientView")
          functions.showMessageToSnackbar(
            context: context,
            message: "AchatClients chargés !",
            icon: Icon(
              Icons.info_rounded,
              color: Color.fromRGBO(60, 141, 188, 1),
            ),
          );
          */
        // ? create list of achatClient
        List achatClientResponse = json.decode(this.response.body)['rows'];
        AchatClient.totalAchat = json.decode(this.response.body)['totalAchat'];
        AchatClient.totalAcompte =
            json.decode(this.response.body)['totalAcompte'];
        AchatClient.totalRemise =
            json.decode(this.response.body)['totalRemise'];
        // ? Load AchatClient instance
        if (achatClientResponse.isNotEmpty)
          AchatClient.achatClient =
              AchatClient.fromJson(achatClientResponse[0]);
        List<AchatClient> achatClient = [
          for (var achatClient in achatClientResponse)
            // ? filter achat client by Research
            if (Research.type == '')
              AchatClient.fromJson(achatClient) // ! Get all achatClient
            else if (Research.type == 'AchatClient' &&
                Research.searchBy == 'Numero facture' &&
                achatClient['numero_facture']
                    .toLowerCase()
                    .contains(Research.value.toLowerCase()))
              AchatClient.fromJson(
                  achatClient) // ! Get achatClient by numero facture
            else if (Research.type == 'AchatClient' &&
                Research.searchBy == 'Date' &&
                achatClient['date_ventes'] != null)
              // ? AchatClient in research date interval
              if ((Research.startDate != null && Research.endDate != null) &&
                  (DateFormat('dd-MM-yyyy')
                              .parse(achatClient['date_ventes'])
                              .compareTo(Research.startDate!) >=
                          0 &&
                      DateFormat('dd-MM-yyyy')
                              .parse(achatClient['date_ventes'])
                              .compareTo(Research.endDate!) <=
                          0))
                AchatClient.fromJson(
                    achatClient) // ! Get achatClient in date interval
              else if (Research.startDate != null &&
                  Research.endDate == null &&
                  DateFormat('dd-MM-yyyy')
                          .parse(achatClient['date_ventes'])
                          .compareTo(Research.startDate!) >=
                      0)
                AchatClient.fromJson(
                    achatClient) // ! Get achatClient after startDate
              else if (Research.endDate != null &&
                  Research.startDate == null &&
                  DateFormat('dd-MM-yyyy')
                          .parse(achatClient['date_ventes'])
                          .compareTo(Research.endDate!) <=
                      0)
                AchatClient.fromJson(
                    achatClient) // ! Get achatClient before endDate
          // ? take all achatClient
          //AchatClient.fromJson(achatClient), // ! debug
          // ? take only achatClient created by the actual user
          //if (achatClient['created_by'] == User.id)
          //AchatClient.fromJson(achatClient), // ! production
        ];
        // ? return list of achatClient
        return achatClient;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        this.requestSuccess = false;
        // ? Show error snack bar
        /*if (ScreenController.actualView == "AchatClientView")
          functions.errorSnackbar(
            context: context,
            message: "Echec de récupération des achatClient",
          );*/
        return <AchatClient>[];
        //throw Exception('Failed to load user datas');
      }
    } catch (error) {
      print(
          'API ERROR: Get AchatClient Model Error -> ${error.runtimeType} -> $error');
      /*if (error is SocketException || error is FormatException)
        functions.socketErrorSnackbar(context: context);*/
      return <AchatClient>[];
    }
  }

  // todo: get clients method
  Future<List<Reglement>> getReglements({required int id}) async {
    this.url = this.routes['getReglements'].toString().replaceAll(
          // ? Replace {id} by true value
          '{client}',
          id.toString(),
        ); // set url
    //print('get clients token: ' + Auth.token!);
    try {
      // ? getting datas from url
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.get(
        Uri.parse(this.url),
        headers: {
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
      );
      // ? Check the response status code
      if (this.response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        this.requestSuccess = true;
        //print(this.response.body);
        // ? Show success snack bar
        /*
        if (ScreenController.actualView == "ReglementView")
          functions.showMessageToSnackbar(
            context: context,
            message: "Reglements chargés !",
            icon: Icon(
              Icons.info_rounded,
              color: Color.fromRGBO(60, 141, 188, 1),
            ),
          );
          */
        // ? create list of achatClient
        List reglementResponse = json.decode(this.response.body)['rows'];
        List<Reglement> reglement = [
          for (var reglement in reglementResponse)
            // ? filter achat client by Research
            if (Research.type == '')
              Reglement.fromJson(reglement) // ! Get all reglement
            else if (Research.type == 'Reglement' &&
                Research.searchBy == 'Date' &&
                reglement['date_ventes'] != null)
              // ? Reglement in research date interval
              if ((Research.startDate != null && Research.endDate != null) &&
                  (DateFormat('dd-MM-yyyy')
                              .parse(reglement['date_reglement'])
                              .compareTo(Research.startDate!) >=
                          0 &&
                      DateFormat('dd-MM-yyyy')
                              .parse(reglement['date_reglement'])
                              .compareTo(Research.endDate!) <=
                          0))
                Reglement.fromJson(
                    reglement) // ! Get reglement in date interval
              else if (Research.startDate != null &&
                  Research.endDate == null &&
                  DateFormat('dd-MM-yyyy')
                          .parse(reglement['date_reglement'])
                          .compareTo(Research.startDate!) >=
                      0)
                Reglement.fromJson(reglement) // ! Get reglement after startDate
              else if (Research.endDate != null &&
                  Research.startDate == null &&
                  DateFormat('dd-MM-yyyy')
                          .parse(reglement['date_reglement'])
                          .compareTo(Research.endDate!) <=
                      0)
                Reglement.fromJson(reglement) // ! Get reglement before endDate
        ];
        // ? return list of reglement
        return reglement;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        this.requestSuccess = false;
        // ? Show error snack bar
        /*if (ScreenController.actualView == "ReglementView")
          functions.errorSnackbar(
            context: context,
            message: "Echec de récupération des reglement",
          );*/
        return <Reglement>[];
        //throw Exception('Failed to load user datas');
      }
    } catch (error) {
      print(
          'API ERROR: Get Reglement Model Error -> ${error.runtimeType} -> $error');
      /*if (error is SocketException || error is FormatException)
        functions.socketErrorSnackbar(context: context);*/
      return <Reglement>[];
    }
  }

  // todo: get articles method
  Future<List<Article>> getArticlesPlusAchetes(int id) async {
    this.url = this.routes['getArticlesPlusAchetes'].toString().replaceAll(
          // ? Replace {id} by true value
          '{client}',
          id.toString(),
        ); // set url
    try {
      // ? getting datas from url
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.get(
        Uri.parse(this.url),
        headers: {
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
      );
      // ? Check the response status code
      if (this.response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        this.requestSuccess = true;
        print("Articles response -> ${this.response.body}");
        // ? create list of articles
        List articleResponse = json.decode(this.response.body)['rows'];
        List<Article> articles = [
          for (var article in articleResponse)
            Article.fromJson(article) // ! Get all articles
        ];
        // ? return list of articles
        return articles;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        this.requestSuccess = false;
        return <Article>[];
        //throw Exception('Failed to load user datas');
      }
    } catch (error) {
      print(
          'API ERROR: Get Articles Model Error ${error.runtimeType} -> $error');
      return <Article>[];
    }
  }

  // todo: get meilleurs clients method
  Future<List<Client>> getBestClients(var context) async {
    this.url = this.routes['getBestClients'].toString(); // set login url
    //print(this.url); // ! debug
    try {
      // ? getting datas from url
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.get(
        Uri.parse(this.url),
        headers: {
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
      );
      // ? Check the response status code
      if (this.response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        this.requestSuccess = true;
        //print(this.response.body);
        // ? Show success snack bar
        /*if (ScreenController.actualView == "HomeView" &&
            ScreenController.reloadDashboard)
          functions.showMessageToSnackbar(
            context: context,
            message: "Meilleurs clients chargés !",
            icon: Icon(
              Icons.info_rounded,
              color: Color.fromRGBO(60, 141, 188, 1),
            ),
          );*/
        // ? create list of clients
        List clientResponse = json.decode(this.response.body)['rows'];
        List<Client> clients = [
          for (var client in clientResponse) Client.fromJson(client), // ! debug
          // ? take only client created by the actual user
          //if (client['created_by'] == User.id)
          //Client.fromJson(client), // ! production
        ];
        // ? return list of clients
        return clients;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        this.requestSuccess = false;
        // ? Show error snack bar
        /*if (ScreenController.actualView == "HomeView")
          functions.errorSnackbar(
            context: context,
            message: "Echec de récupération des meilleurs clients",
          );*/
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
  Future<List<Client>> getDettesClients(var context) async {
    this.url = this.routes['getDettesClients'].toString(); // set login url
    //print(this.url); // ! debug
    try {
      // ? getting datas from url
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.get(
        Uri.parse(this.url),
        headers: {
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
      );
      // ? Check the response status code
      if (this.response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        this.requestSuccess = true;
        //print(this.response.body);
        // ? Show success snack bar
        /*if (ScreenController.actualView == "HomeView" &&
            ScreenController.reloadDashboard)
          functions.showMessageToSnackbar(
            context: context,
            message: "Clients moins rentables chargés !",
            icon: Icon(
              Icons.info_rounded,
              color: Color.fromRGBO(60, 141, 188, 1),
            ),
          );*/
        // ? create list of clients
        List clientResponse = json.decode(this.response.body)['rows'];
        List<Client> clients = [
          for (var client in clientResponse) Client.fromJson(client), // ! debug
          // ? take only client created by the actual user
          //if (client['created_by'] == User.id)
          //Client.fromJson(client), // ! production
        ];
        // ? return list of clients
        return clients;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        this.requestSuccess = false;
        // ? Show error snack bar
        /*if (ScreenController.actualView == "HomeView")
          functions.errorSnackbar(
            context: context,
            message: "Echec de récupération des clients les moins rentable",
          );*/
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
  Future<List<Client>> getWorstRentabilityClients(var context) async {
    this.url =
        this.routes['getWorstRentabilityClients'].toString(); // set login url
    //print(this.url); // ! debug
    try {
      // ? getting datas from url
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.get(
        Uri.parse(this.url),
        headers: {
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
      );
      // ? Check the response status code
      if (this.response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        this.requestSuccess = true;
        //print(this.response.body);
        // ? Show success snack bar
        /*if (ScreenController.actualView == "HomeView" &&
            ScreenController.reloadDashboard)
          functions.showMessageToSnackbar(
            context: context,
            message: "Clients moins rentables chargés !",
            icon: Icon(
              Icons.info_rounded,
              color: Color.fromRGBO(60, 141, 188, 1),
            ),
          );*/
        // ? create list of clients
        List clientResponse = json.decode(this.response.body)['rows'];
        List<Client> clients = [
          for (var client in clientResponse) Client.fromJson(client), // ! debug
          // ? take only client created by the actual user
          //if (client['created_by'] == User.id)
          //Client.fromJson(client), // ! production
        ];
        // ? return list of clients
        return clients;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        this.requestSuccess = false;
        // ? Show error snack bar
        /*if (ScreenController.actualView == "HomeView")
          functions.errorSnackbar(
            context: context,
            message: "Echec de récupération des clients les moins rentable",
          );*/
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
  Future<List<Commande>> getCommandes(var context) async {
    this.url = this.routes['getCommandes'].toString(); // set login url
    //print(this.url); // ! debug
    try {
      // ? getting datas from url
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.get(
        Uri.parse(this.url),
        headers: {
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
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
        // ? create list of commandes
        List commandeResponse = json.decode(this.response.body)['rows'];
        List<Commande> commandes = [
          for (var commande in commandeResponse)
            // ? filter commandes by Research
            if (Research.type == 'Commande' &&
                Research.searchBy == 'Par N° de bon' &&
                commande['numero_bon']
                    .toLowerCase()
                    .contains(Research.value.toLowerCase()))
              Commande.fromJson(commande) // ! Get commandes by numero bon
            else if (Research.type == 'Commande' &&
                Research.searchBy == 'Par date' &&
                DateTime.parse(commande['date_bon_commande']).compareTo(
                        DateTime.parse(Research.value.toLowerCase())) ==
                    0)
              Commande.fromJson(commande) // ! Get commandes by date
            else if (Research.type == 'Commande' &&
                Research.searchBy == 'Fournisseur' &&
                commande['fournisseur']['full_name_fournisseur']
                    .toLowerCase()
                    .contains(Research.value.toLowerCase()))
              Commande.fromJson(commande) // ! Get commandes by pays
            else if (Research.type == '')
              Commande.fromJson(commande) // ! Get all commandes

          // ? take all commandes
          //Commande.fromJson(commande), // ! debug
          // ? take only commande created by the actual user
          //if (commande['created_by'] == User.id)
          //Commande.fromJson(commande), // ! production
        ];
        //print('List: $countries'); // ! debug
        // ? return list of commandes
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
  Future<List<Pays>> getPays(var context) async {
    this.url = this.routes['getNations'].toString(); // set login url
    //print(this.url); // ! debug
    try {
      // ? getting datas from url
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.get(
        Uri.parse(this.url),
        headers: {
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
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
          for (var pays in paysResponse)
            // ? filter pays by Research
            if (Research.type == 'Pays' &&
                pays['libelle_nation']
                    .toLowerCase()
                    .contains(Research.value.toLowerCase()))
              Pays.fromJson(pays) // ! Get pays by nom
            else if (Research.type == '')
              Pays.fromJson(pays) // ! Get all pays
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
  Future<List<Regime>> getRegimes(var context) async {
    this.url = this.routes['getRegimes'].toString(); // set login url
    try {
      // ? getting datas from url
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.get(
        Uri.parse(this.url),
        headers: {
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
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
          for (var regime in regimeResponse)
            // ? filter regimes by Research
            if (Research.type == 'Regime' &&
                regime['libelle_regime']
                    .toLowerCase()
                    .contains(Research.value.toLowerCase()))
              Regime.fromJson(regime) // ! Get regimes by name
            else if (Research.type == '')
              Regime.fromJson(regime) // ! Get all regimes

          // ? take all regimes
          //Regime.fromJson(regime), // ! debug
          // ? take only regime created by the actual user
          //if (regime['created_by'] == User.id)
          //Regime.fromJson(regime), // ! production
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
  Future<List<Banque>> getBanques(var context) async {
    this.url = this.routes['getBanques'].toString(); // set login url
    try {
      // ? getting datas from url
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.get(
        Uri.parse(this.url),
        headers: {
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
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
        // ? create list of banques
        List banqueResponse = json.decode(this.response.body)['rows'];
        List<Banque> banques = [
          for (var banque in banqueResponse)
            // ? filter banques by Research
            if (Research.type == 'Banque' &&
                banque['libelle_banque']
                    .toLowerCase()
                    .contains(Research.value.toLowerCase()))
              Banque.fromJson(banque) // ! Get banques by name
            else if (Research.type == '')
              Banque.fromJson(banque) // ! Get all banques

          // ? take all banques
          //Banque.fromJson(banque), // ! debug
          // ? take only banque created by the actual user
          //if (banque['created_by'] == User.id)
          //Banque.fromJson(banque), // ! production
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
  Future<List<Caisse>> getCaisses(var context) async {
    this.url = this.routes['getCaisses'].toString(); // set login url
    try {
      // ? getting datas from url
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.get(
        Uri.parse(this.url),
        headers: {
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
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
        // ? create list of caisses
        List caisseResponse = json.decode(this.response.body)['rows'];
        List<Caisse> caisses = [
          for (var caisse in caisseResponse)
            // ? filter caisses by Research
            if (Research.type == 'Caisse' &&
                caisse['libelle_caisse']
                    .toLowerCase()
                    .contains(Research.value.toLowerCase()))
              Caisse.fromJson(caisse) // ! Get caisses by name
            else if (Research.type == '')
              Caisse.fromJson(caisse) // ! Get all caisses

          // ? take all caisses
          //Caisse.fromJson(caisse), // ! debug
          // ? take only caisse created by the actual user
          //if (caisse['created_by'] == User.id)
          //Caisse.fromJson(caisse), // ! production
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
  Future<List<Tva>> getTvas(var context) async {
    this.url = this.routes['getTvas'].toString(); // set login url
    try {
      // ? getting datas from url
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.get(
        Uri.parse(this.url),
        headers: {
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
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
          for (var tva in tvaResponse)
            // ? filter tvas by Research
            if (Research.type == 'Tva' &&
                tva['libelle_tva']
                    .toLowerCase()
                    .contains(Research.value.toLowerCase()))
              Tva.fromJson(tva) // ! Get tvas by name
            else if (Research.type == '')
              Tva.fromJson(tva) // ! Get all tvas

          // ? take all tvas
          //Tva.fromJson(tva), // ! debug
          // ? take only tva created by the actual user
          //if (tva['created_by'] == User.id)
          //Tva.fromJson(tva), // ! production
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
  Future<List<Categorie>> getCategories(var context) async {
    this.url = this.routes['getCategories'].toString(); // set login url
    try {
      // ? getting datas from url
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.get(
        Uri.parse(this.url),
        headers: {
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
      );
      // ? Check the response status code
      if (this.response.statusCode == 200) {
        this.requestSuccess = true;
        //print('Réponse du serveur: ' + this.response.body);
        // ? Show success snack bar
        if (ScreenController.actualView == "CategorieView")
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
        List<Categorie> categories = [
          for (var categorie in categorieResponse)
            // ? filter categories by Research
            if (Research.type == 'Categorie' &&
                categorie['libelle_categorie']
                    .toLowerCase()
                    .contains(Research.value.toLowerCase()))
              Categorie.fromJson(categorie) // ! Get categories by name
            else if (Research.type == '')
              Categorie.fromJson(categorie) // ! Get all categories

          // ? take all categories
          //Categorie.fromJson(categorie), // ! debug
          // ? take only categorie created by the actual user
          //if (categorie['created_by'] == User.id)
          //Categorie.fromJson(categorie), // ! production
        ];
        // ? return list of categories
        return categories;
      } else {
        this.requestSuccess = false;
        // ? Show error snack bar
        if (ScreenController.actualView == "CategorieView")
          functions.errorSnackbar(
            context: context,
            message: "Echec de récupération des catégories",
          );
        return <Categorie>[];
      }
    } catch (error) {
      print(
          'API ERROR: Get Categorie Model Error -> ${error.runtimeType} -> $error');
      if (error is SocketException || error is FormatException)
        functions.socketErrorSnackbar(context: context);
      return <Categorie>[];
    }
  }

  // todo: get sous catégories method
  Future<List<SousCategorie>> getSousCategories(var context) async {
    this.url = this.routes['getSousCategories'].toString(); // set login url
    try {
      // ? getting datas from url
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.get(
        Uri.parse(this.url),
        headers: {
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
      );
      // ? Check the response status code
      if (this.response.statusCode == 200) {
        this.requestSuccess = true;
        //print('Réponse du serveur: ' + this.response.body);
        // ? Show success snack bar
        if (ScreenController.actualView == "SousCategorieView")
          functions.showMessageToSnackbar(
            context: context,
            message: "Sous catégories chargées !",
            icon: Icon(
              Icons.info_rounded,
              color: Color.fromRGBO(60, 141, 188, 1),
            ),
          );
        // ? create list of taxs
        List sousCategorieResponse = json.decode(this.response.body)['rows'];
        List<SousCategorie> sousCategories = [
          for (var sousCategorie in sousCategorieResponse)
            // ? filter sousCategories by Research
            if (Research.type == 'SousCategorie' &&
                sousCategorie['libelle_sous_categorie']
                    .toLowerCase()
                    .contains(Research.value.toLowerCase()))
              SousCategorie.fromJson(
                  sousCategorie) // ! Get sousCategories by name
            else if (Research.type == '')
              SousCategorie.fromJson(sousCategorie) // ! Get all sousCategories

          // ? take all sousCategories
          //SousCategorie.fromJson(sousCategorie), // ! debug
          // ? take only sousCategorie created by the actual user
          //if (sousCategorie['created_by'] == User.id)
          //SousCategorie.fromJson(sousCategorie), // ! production
        ];
        // ? return list of sous categories
        return sousCategories;
      } else {
        this.requestSuccess = false;
        // ? Show error snack bar
        if (ScreenController.actualView == "SousCategorieView")
          functions.errorSnackbar(
            context: context,
            message: "Echec de récupération des sous catégories",
          );
        return <SousCategorie>[];
      }
    } catch (error) {
      print(
          'API ERROR: SousCategorie Model Error -> ${error.runtimeType} -> $error');
      if (error is SocketException || error is FormatException)
        functions.socketErrorSnackbar(context: context);
      return <SousCategorie>[];
    }
  }

  // todo: get dépot method
  Future<List<Depot>> getDepots(var context) async {
    this.url = this.routes['getDepots'].toString(); // set login url
    try {
      // ? getting datas from url
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.get(
        Uri.parse(this.url),
        headers: {
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
      );
      // ? Check the response status code
      if (this.response.statusCode == 200) {
        this.requestSuccess = true;
        //print('Réponse du serveur: ' + this.response.body);
        // ? Show success snack bar
        if (ScreenController.actualView == "DepotView")
          functions.showMessageToSnackbar(
            context: context,
            message: "Dépôts chargés !",
            icon: Icon(
              Icons.info_rounded,
              color: Color.fromRGBO(60, 141, 188, 1),
            ),
          );
        // ? create list of depot
        List depotResponse = json.decode(this.response.body)['rows'];
        List<Depot> depots = [
          for (var depot in depotResponse)
            // ? filter depots by Research
            if (Research.type == 'Depot' &&
                depot['libelle_depot']
                    .toLowerCase()
                    .contains(Research.value.toLowerCase()))
              Depot.fromJson(depot) // ! Get depots by name
            else if (Research.type == '')
              Depot.fromJson(depot) // ! Get all depots

          // ? take all depots
          //Depot.fromJson(depot), // ! debug
          // ? take only depot created by the actual user
          //if (depot['created_by'] == User.id)
          //Depot.fromJson(depot), // ! production
        ];
        // ? return list of depots
        return depots;
      } else {
        this.requestSuccess = false;
        // ? Show error snack bar
        if (ScreenController.actualView == "DepotView")
          functions.errorSnackbar(
            context: context,
            message: "Echec de récupération des sous catégories",
          );
        return <Depot>[];
      }
    } catch (error) {
      print('API ERROR: Depot Model Error -> ${error.runtimeType} -> $error');
      if (error is SocketException || error is FormatException)
        functions.socketErrorSnackbar(context: context);
      return <Depot>[];
    }
  }

  // todo: get moyen reglement method
  Future<List<MoyenReglement>> getMoyenReglements(var context) async {
    this.url = this.routes['getMoyenReglements'].toString(); // set login url
    try {
      // ? getting datas from url
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.get(
        Uri.parse(this.url),
        headers: {
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
      );
      // ? Check the response status code
      if (this.response.statusCode == 200) {
        this.requestSuccess = true;
        //print('Réponse du serveur: ' + this.response.body);
        // ? Show success snack bar
        if (ScreenController.actualView == "MoyenReglementView")
          functions.showMessageToSnackbar(
            context: context,
            message: "Moyens de reglement chargés !",
            icon: Icon(
              Icons.info_rounded,
              color: Color.fromRGBO(60, 141, 188, 1),
            ),
          );
        // ? create list of taxs
        List moyenReglementResponse = json.decode(this.response.body)['rows'];
        List<MoyenReglement> moyenReglements = [
          for (var moyenReglement in moyenReglementResponse)
            // ? filter moyenReglements by Research
            if (Research.type == 'MoyenReglement' &&
                moyenReglement['libelle_moyen_reglement']
                    .toLowerCase()
                    .contains(Research.value.toLowerCase()))
              MoyenReglement.fromJson(
                  moyenReglement) // ! Get moyenReglements by name
            else if (Research.type == '')
              MoyenReglement.fromJson(
                  moyenReglement) // ! Get all moyenReglements

          // ? take all moyenReglements
          //MoyenReglement.fromJson(moyenReglement), // ! debug
          // ? take only moyenReglement created by the actual user
          //if (moyenReglement['created_by'] == User.id)
          //MoyenReglement.fromJson(moyenReglement), // ! production
        ];
        // ? return list of moyenReglements
        return moyenReglements;
      } else {
        this.requestSuccess = false;
        // ? Show error snack bar
        if (ScreenController.actualView == "MoyenReglementView")
          functions.errorSnackbar(
            context: context,
            message: "Echec de récupération des moyens de reglement",
          );
        return <MoyenReglement>[];
      }
    } catch (error) {
      print(
          'API ERROR: Get MoyenReglement Model Error -> ${error.runtimeType} -> $error');
      if (error is SocketException || error is FormatException)
        functions.socketErrorSnackbar(context: context);
      return <MoyenReglement>[];
    }
  }

  // todo: get rayon method
  Future<List<Rayon>> getRayons(var context) async {
    this.url = this.routes['getRayons'].toString(); // set login url
    try {
      // ? getting datas from url
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.get(
        Uri.parse(this.url),
        headers: {
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
      );
      // ? Check the response status code
      if (this.response.statusCode == 200) {
        this.requestSuccess = true;
        //print('Réponse du serveur: ' + this.response.body);
        // ? Show success snack bar
        if (ScreenController.actualView == "RayonView")
          functions.showMessageToSnackbar(
            context: context,
            message: "Rayons chargés !",
            icon: Icon(
              Icons.info_rounded,
              color: Color.fromRGBO(60, 141, 188, 1),
            ),
          );
        // ? create list of taxs
        List rayonResponse = json.decode(this.response.body)['rows'];
        List<Rayon> rayons = [
          for (var rayon in rayonResponse)
            // ? filter rayons by Research
            if (Research.type == 'Rayon' &&
                rayon['libelle_rayon']
                    .toLowerCase()
                    .contains(Research.value.toLowerCase()))
              Rayon.fromJson(rayon) // ! Get rayons by name
            else if (Research.type == '')
              Rayon.fromJson(rayon) // ! Get all rayons

          // ? take all rayons
          //Rayon.fromJson(rayon), // ! debug
          // ? take only rayon created by the actual user
          //if (rayon['created_by'] == User.id)
          //Rayon.fromJson(rayon), // ! production
        ];
        // ? return list of rayons
        return rayons;
      } else {
        this.requestSuccess = false;
        // ? Show error snack bar
        if (ScreenController.actualView == "RayonView")
          functions.errorSnackbar(
            context: context,
            message: "Echec de récupération des rayons",
          );
        return <Rayon>[];
      }
    } catch (error) {
      print(
          'API ERROR: Get Rayon Model Error -> ${error.runtimeType} -> $error');
      if (error is SocketException || error is FormatException)
        functions.socketErrorSnackbar(context: context);
      return <Rayon>[];
    }
  }

  // todo: get rangee method
  Future<List<Rangee>> getRangees(var context) async {
    this.url = this.routes['getRangees'].toString(); // set login url
    try {
      // ? getting datas from url
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.get(
        Uri.parse(this.url),
        headers: {
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
      );
      // ? Check the response status code
      if (this.response.statusCode == 200) {
        this.requestSuccess = true;
        //print('Réponse du serveur: ' + this.response.body);
        // ? Show success snack bar
        if (ScreenController.actualView == "RangeeView")
          functions.showMessageToSnackbar(
            context: context,
            message: "Rangees chargés !",
            icon: Icon(
              Icons.info_rounded,
              color: Color.fromRGBO(60, 141, 188, 1),
            ),
          );
        // ? create list of taxs
        List rangeeResponse = json.decode(this.response.body)['rows'];
        List<Rangee> rangees = [
          for (var rangee in rangeeResponse)
            // ? filter rangees by Research
            if (Research.type == 'Rangee' &&
                rangee['libelle_rangee']
                    .toLowerCase()
                    .contains(Research.value.toLowerCase()))
              Rangee.fromJson(rangee) // ! Get rangees by name
            else if (Research.type == '')
              Rangee.fromJson(rangee) // ! Get all rangees

          // ? take all rangees
          //Rangee.fromJson(rangee), // ! debug
          // ? take only rangee created by the actual user
          //if (rangee['created_by'] == User.id)
          //Rangee.fromJson(rangee), // ! production
        ];
        // ? return list of rangees
        return rangees;
      } else {
        this.requestSuccess = false;
        // ? Show error snack bar
        if (ScreenController.actualView == "RangeeView")
          functions.errorSnackbar(
            context: context,
            message: "Echec de récupération des rangées",
          );
        return <Rangee>[];
      }
    } catch (error) {
      print(
          'API ERROR: Get Rangee Model Error -> ${error.runtimeType} -> $error');
      if (error is SocketException || error is FormatException)
        functions.socketErrorSnackbar(context: context);
      return <Rangee>[];
    }
  }

  // todo: get casier method
  Future<List<Casier>> getCasiers(var context) async {
    this.url = this.routes['getCasiers'].toString(); // set login url
    try {
      // ? getting datas from url
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.get(
        Uri.parse(this.url),
        headers: {
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
      );
      // ? Check the response status code
      if (this.response.statusCode == 200) {
        this.requestSuccess = true;
        //print('Réponse du serveur: ' + this.response.body);
        // ? Show success snack bar
        if (ScreenController.actualView == "CasierView")
          functions.showMessageToSnackbar(
            context: context,
            message: "Casiers chargés !",
            icon: Icon(
              Icons.info_rounded,
              color: Color.fromRGBO(60, 141, 188, 1),
            ),
          );
        // ? create list of taxs
        List casierResponse = json.decode(this.response.body)['rows'];
        List<Casier> casiers = [
          for (var casier in casierResponse)
            // ? filter casiers by Research
            if (Research.type == 'Casier' &&
                casier['libelle_casier']
                    .toLowerCase()
                    .contains(Research.value.toLowerCase()))
              Casier.fromJson(casier) // ! Get casiers by name
            else if (Research.type == '')
              Casier.fromJson(casier) // ! Get all casiers

          // ? take all casiers
          //Casier.fromJson(casier), // ! debug
          // ? take only casier created by the actual user
          //if (casier['created_by'] == User.id)
          //Casier.fromJson(casier), // ! production
        ];
        // ? return list of casiers
        return casiers;
      } else {
        this.requestSuccess = false;
        // ? Show error snack bar
        if (ScreenController.actualView == "CasierView")
          functions.errorSnackbar(
            context: context,
            message: "Echec de récupération des casiers",
          );
        return <Casier>[];
      }
    } catch (error) {
      print(
          'API ERROR: Get Casier Model Error -> ${error.runtimeType} -> $error');
      if (error is SocketException || error is FormatException)
        functions.socketErrorSnackbar(context: context);
      return <Casier>[];
    }
  }

  // todo: get unités method
  Future<List<Unite>> getUnites(var context) async {
    this.url = this.routes['getUnites'].toString(); // set login url
    try {
      // ? getting datas from url
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.get(
        Uri.parse(this.url),
        headers: {
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
      );
      // ? Check the response status code
      if (this.response.statusCode == 200) {
        this.requestSuccess = true;
        //print('Réponse du serveur: ' + this.response.body);
        // ? Show success snack bar
        if (ScreenController.actualView == "UniteView")
          functions.showMessageToSnackbar(
            context: context,
            message: "Unités chargées !",
            icon: Icon(
              Icons.info_rounded,
              color: Color.fromRGBO(60, 141, 188, 1),
            ),
          );
        // ? create list of taxs
        List uniteResponse = json.decode(this.response.body)['rows'];
        List<Unite> unites = [
          for (var unite in uniteResponse)
            // ? filter unites by Research
            if (Research.type == 'Unite' &&
                unite['libelle_unite']
                    .toLowerCase()
                    .contains(Research.value.toLowerCase()))
              Unite.fromJson(unite) // ! Get unites by name
            else if (Research.type == '')
              Unite.fromJson(unite) // ! Get all unites

          // ? take all unites
          //Unite.fromJson(unite), // ! debug
          // ? take only unite created by the actual user
          //if (unite['created_by'] == User.id)
          //Unite.fromJson(unite), // ! production
        ];
        // ? return list of sous categories
        return unites;
      } else {
        this.requestSuccess = false;
        // ? Show error snack bar
        if (ScreenController.actualView == "UniteView")
          functions.errorSnackbar(
            context: context,
            message: "Echec de récupération des sous catégories",
          );
        return <Unite>[];
      }
    } catch (error) {
      print('API ERROR: Unite Model Error -> ${error.runtimeType} -> $error');
      if (error is SocketException || error is FormatException)
        functions.socketErrorSnackbar(context: context);
      return <Unite>[];
    }
  }

  // todo: get taille method
  Future<List<Taille>> getTailles(var context) async {
    this.url = this.routes['getTailles'].toString(); // set login url
    try {
      // ? getting datas from url
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.get(
        Uri.parse(this.url),
        headers: {
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
      );
      // ? Check the response status code
      if (this.response.statusCode == 200) {
        this.requestSuccess = true;
        //print('Réponse du serveur: ' + this.response.body);
        // ? Show success snack bar
        if (ScreenController.actualView == "TailleView")
          functions.showMessageToSnackbar(
            context: context,
            message: "Tailles chargés !",
            icon: Icon(
              Icons.info_rounded,
              color: Color.fromRGBO(60, 141, 188, 1),
            ),
          );
        // ? create list of taxs
        List tailleResponse = json.decode(this.response.body)['rows'];
        List<Taille> tailles = [
          for (var taille in tailleResponse)
            // ? filter tailles by Research
            if (Research.type == 'Taille' &&
                taille['libelle_taille']
                    .toLowerCase()
                    .contains(Research.value.toLowerCase()))
              Taille.fromJson(taille) // ! Get tailles by name
            else if (Research.type == '')
              Taille.fromJson(taille) // ! Get all tailles

          // ? take all tailles
          //Taille.fromJson(taille), // ! debug
          // ? take only taille created by the actual user
          //if (taille['created_by'] == User.id)
          //Taille.fromJson(taille), // ! production
        ];
        // ? return list of tailles
        return tailles;
      } else {
        this.requestSuccess = false;
        // ? Show error snack bar
        if (ScreenController.actualView == "TailleView")
          functions.errorSnackbar(
            context: context,
            message: "Echec de récupération des tailles",
          );
        return <Taille>[];
      }
    } catch (error) {
      print(
          'API ERROR: Get Taille Model Error -> ${error.runtimeType} -> $error');
      if (error is SocketException || error is FormatException)
        functions.socketErrorSnackbar(context: context);
      return <Taille>[];
    }
  }

  // todo: get casier method
  Future<List<Divers>> getDivers(var context) async {
    this.url = this.routes['getDivers'].toString(); // set login url
    try {
      // ? getting datas from url
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.get(
        Uri.parse(this.url),
        headers: {
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
      );
      // ? Check the response status code
      if (this.response.statusCode == 200) {
        this.requestSuccess = true;
        //print('Réponse du serveur: ' + this.response.body);
        // ? Show success snack bar
        if (ScreenController.actualView == "DiversView")
          functions.showMessageToSnackbar(
            context: context,
            message: "Divers chargés !",
            icon: Icon(
              Icons.info_rounded,
              color: Color.fromRGBO(60, 141, 188, 1),
            ),
          );
        // ? create list of taxs
        List diversResponse = json.decode(this.response.body)['rows'];
        List<Divers> diversList = [
          for (var divers in diversResponse)
            // ? filter divers by Research
            if (Research.type == 'Divers' &&
                divers['libelle_divers']
                    .toLowerCase()
                    .contains(Research.value.toLowerCase()))
              Divers.fromJson(divers) // ! Get divers by name
            else if (Research.type == '')
              Divers.fromJson(divers) // ! Get all divers

          // ? take all divers
          //Divers.fromJson(divers), // ! debug
          // ? take only divers created by the actual user
          //if (divers['created_by'] == User.id)
          //Divers.fromJson(divers), // ! production
        ];
        // ? return list of diversList
        return diversList;
      } else {
        this.requestSuccess = false;
        // ? Show error snack bar
        if (ScreenController.actualView == "DiversView")
          functions.errorSnackbar(
            context: context,
            message: "Echec de récupération des divers",
          );
        return <Divers>[];
      }
    } catch (error) {
      print(
          'API ERROR: Get Divers Model Error -> ${error.runtimeType} -> $error');
      if (error is SocketException || error is FormatException)
        functions.socketErrorSnackbar(context: context);
      return <Divers>[];
    }
  }

  // todo: get casier method
  Future<List<CategorieDepense>> getCategorieDepenses(var context) async {
    this.url = this.routes['getCategorieDepenses'].toString(); // set login url
    try {
      // ? getting datas from url
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.get(
        Uri.parse(this.url),
        headers: {
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
      );
      // ? Check the response status code
      if (this.response.statusCode == 200) {
        this.requestSuccess = true;
        //print('Réponse du serveur: ' + this.response.body);
        // ? Show success snack bar
        if (ScreenController.actualView == "CategorieDepenseView")
          functions.showMessageToSnackbar(
            context: context,
            message: "Categories dépense chargés !",
            icon: Icon(
              Icons.info_rounded,
              color: Color.fromRGBO(60, 141, 188, 1),
            ),
          );
        // ? create list of taxs
        List categorieDepenseResponse = json.decode(this.response.body)['rows'];
        List<CategorieDepense> categorieDepenses = [
          for (var categorieDepense in categorieDepenseResponse)
            // ? filter categorieDepenses by Research
            if (Research.type == 'CategorieDepense' &&
                categorieDepense['libelle_categorie_depense']
                    .toLowerCase()
                    .contains(Research.value.toLowerCase()))
              CategorieDepense.fromJson(
                  categorieDepense) // ! Get categorieDepenses by name
            else if (Research.type == '')
              CategorieDepense.fromJson(
                  categorieDepense) // ! Get all categorieDepenses

          // ? take all categorieDepenses
          //CategorieDepense.fromJson(categorieDepense), // ! debug
          // ? take only categorieDepense created by the actual user
          //if (categorieDepense['created_by'] == User.id)
          //CategorieDepense.fromJson(categorieDepense), // ! production
        ];
        // ? return list of categorieDepenses
        return categorieDepenses;
      } else {
        this.requestSuccess = false;
        // ? Show error snack bar
        if (ScreenController.actualView == "CategorieDepenseView")
          functions.errorSnackbar(
            context: context,
            message: "Echec de récupération des catégories dépense",
          );
        return <CategorieDepense>[];
      }
    } catch (error) {
      print(
          'API ERROR: Get CategorieDepense Model Error -> ${error.runtimeType} -> $error');
      if (error is SocketException || error is FormatException)
        functions.socketErrorSnackbar(context: context);
      return <CategorieDepense>[];
    }
  }

  // todo: get dashboard stats method
  Future<Map<String, int>> getDashboardStats(var context) async {
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
  Future<List<Fournisseur>> getFournisseurs(var context) async {
    this.url =
        this.routes['getFournisseurs'].toString(); // set get fournisseurs url
    /*SharedPreferences prefs =
        await SharedPreferences.getInstance(); // load SharedPreferences
    String? token = prefs.getString('access_token');*/
    //print('get articles token: ' + Auth.token!);
    try {
      // ? getting datas from url
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.get(
        Uri.parse(this.url),
        headers: {
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
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
            // ? filter fournisseurs by Research
            if (Research.type == 'Fournisseur' &&
                fournisseur['full_name_fournisseur']
                    .toLowerCase()
                    .contains(Research.value.toLowerCase()))
              Fournisseur.fromJson(fournisseur) // ! Get fournisseurs by nom
            else if (Research.type == 'Fournisseur' &&
                Research.searchBy == 'Pays' &&
                fournisseur['nation']['libelle_nation']
                    .toLowerCase()
                    .contains(Research.value.toLowerCase()))
              Fournisseur.fromJson(fournisseur) // ! Get fournisseurs by pays
            else if (Research.type == '')
              Fournisseur.fromJson(fournisseur) // ! Get all fournisseurs

          // ? take all fournisseurs
          //Fournisseur.fromJson(fournisseur), // ! debug
          // ? take only fournisseur created by the actual user
          //if (fournisseur['created_by'] == User.id)
          //Fournisseur.fromJson(fournisseur), // ! production
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
  Future<Map<String, dynamic>> getUserInfo(var context) async {
    this.url = this.routes['userinfo'].toString(); // set login url
    print("[LOG] Auth token -> ${Auth.token}");
    try {
      // ? getting datas from url
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.get(
        Uri.parse(this.url),
        headers: {
          // pass access token into the header
          HttpHeaders.authorizationHeader:
              Auth.token!, //.replaceAll('Bearer ', ''),
        },
      );
      // ? Check the response status code
      if (this.response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        this.requestSuccess = true;
        print('User datas get successfuly !');
        // ? create list for the user datas
        Map<String, dynamic> userInfos = json.decode(this.response.body);
        // ? Get user password from cache in the null case
        if (userInfos['password'] == null || userInfos['password'] == 'null') {
          // load SharedPreferences and get last login password
          SharedPreferences prefs = await SharedPreferences.getInstance();
          userInfos['password'] = prefs.getString('password');
        }
        // ? Load user login in instance
        Auth.user = User.fromJson(userInfos);
        // ? return this list
        return userInfos;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        this.requestSuccess = false;
        print('Failed to get user datas..');
        return {'msg': 'failed to get user datas'};
        //throw Exception('Failed to load user datas');
      }
    } catch (error) {
      print(
          'API ERROR: Get User Infos Error -> ${error.runtimeType} -> $error');
      print(error);
      if (error is SocketException || error is FormatException)
        functions.socketErrorSnackbar(context: context);
      return {'msg': 'API error'};
    }
  }

  // todo: verify login method
  Future<Map<String, dynamic>> verifyLogin(
      var context, String login, String password,
      {bool remember = false}) async {
    this.url = this.routes['login'].toString(); // set login url
    try {
      print("Actual view -> " + ScreenController.actualView);
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

      print('${responseJson.runtimeType} response -> $responseJson');
      // ? Login success
      if (responseJson['access_token'] != null) {
        // ? Save token to the cache
        // load SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', responseJson['access_token']); // save token
        prefs.setString('tokenExpDate',
            responseJson['expires_at']); // save token expiration date
        prefs.setString('password', password); // save password
        // ? Get user informations from the server
        Map<String, dynamic> userInfos = await getUserInfo(context);
        responseJson['login'] = login;
        responseJson['password'] = password;
        responseJson['statut_compte'] =
            (userInfos['statut_compte'] == 1) ? true : false;
        responseJson['created_at'] =
            userInfos['created_at']; //.replaceAll('T', ' ');
        responseJson['updated_at'] =
            userInfos['updated_at']; //.replaceAll('T', ' ');
        print("Réponse du server: $responseJson");
        print("User informations: $userInfos");
        // ? set user informations
        Auth.login(
          token: responseJson['access_token'],
          user: User.fromJson(userInfos),
        );
        print('User token -> ' + responseJson['access_token']!); // ! debug
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
        print("Login error -> ${responseJson['message']}");
        ScreenController.actualView = "LoginView";
        return responseJson; // return to know lodin state
      }
    } catch (error) {
      print('API ERROR: Login Error -> ${error.runtimeType} -> $error');
      /*if (error is SocketException || error is FormatException)
        functions.socketErrorSnackbar(context: context);*/
      return {"access_token": null}; // return to know login state
    }
  }

  // todo: Logout method
  Future<void> logout(var context) async {
    this.url = this.routes['logout'].toString(); // set login url
    try {
      // ? getting datas from url
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.get(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
      );
      // ? Delete user access token
      // load SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Auth.logout();
      prefs.clear();
      prefs.remove('token');
      // Reset drawer animation
      DrawerLayoutController.close();
      // ? Return to LoginView
      functions.openPage(context, LoginView(), mode: 'pushReplacement');
    } catch (error) {
      print('API ERROR: Logout Error -> ${error.runtimeType} -> $error');
      if (ScreenController.actualView != "LoginView") {
        if (error is SocketException || error is FormatException) {
          Navigator.pop(context);
          functions.socketErrorSnackbar(
            context: context,
            message: "Echec de déconnexion, vérifiez votre connexion internet",
          );
        }
      }
    }
  }

  // todo: reset password automatically method
  Future<Map<String, dynamic>> resetPassword(String email) async {
    this.url = this.routes['resetPassword'].toString(); // set url
    try {
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.post(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
        body: {'email': email},
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print(responseJson.runtimeType);
      // ? Save new password to the cache
      // load SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('password', 'zozo33'); // save password
      return responseJson; // return to know if the password has been reset
      // ? Login failed
    } catch (error) {
      print(
          'API ERROR: Reset Password Error -> ${error.runtimeType} -> $error');
      return json.decode(
          this.response.body); // return to know if the password has been reset
    }
  }

  // todo: post client method
  Future<Map<String, dynamic>> postClient({
    required var context,
    required Client client,
  }) async {
    this.url = this.routes['postClient'].toString(); // set client url
    try {
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.post(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
        body: Client.toMap(client),
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
    required var context,
    required Fournisseur fournisseur,
  }) async {
    this.url = this.routes['postFournisseur'].toString(); // set client url
    print('Post Fournisseur: ' + Fournisseur.toMap(fournisseur).toString());
    try {
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.post(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
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
  Future<Map<String, dynamic>> postArticle({
    required var context,
    required Article article,
  }) async {
    this.url = this.routes['postArticle'].toString(); // set client url
    try {
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.post(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
        body: Article.toMap(article),
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
  Future<Map<String, dynamic>> postBanque(
      {required var context, required Banque banque}) async {
    this.url = this.routes['postBanque'].toString(); // set client url
    try {
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.post(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
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
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: post regime method
  Future<Map<String, dynamic>> postRegime({
    required var context,
    required Regime regime,
  }) async {
    this.url = this.routes['postRegime'].toString(); // set client url
    try {
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.post(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
        body: Regime.toMap(regime),
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: post TVA method
  Future<Map<String, dynamic>> postTva({
    required var context,
    required Tva tva,
  }) async {
    this.url = this.routes['postTva'].toString(); // set client url
    try {
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.post(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
        body: Tva.toMap(tva),
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print("Post Tva Error -> $error");
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: post caisse method
  Future<Map<String, dynamic>> postCaisse({
    required var context,
    required Caisse caisse,
  }) async {
    this.url = this.routes['postCaisse'].toString(); // set client url
    try {
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.post(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
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
    required var context,
    required Pays pays,
  }) async {
    this.url = this.routes['postPays'].toString(); // set client url
    try {
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.post(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
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
  Future<Map<String, dynamic>> postCategorie({
    required var context,
    required Categorie categorie,
  }) async {
    this.url = this.routes['postCategorie'].toString(); // set client url
    try {
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.post(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
        body: Categorie.toMap(categorie),
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      // ? Show error snack bar
      if (ScreenController.actualView == "CategorieView") {
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
  Future<Map<String, dynamic>> postSousCategorie({
    required var context,
    required SousCategorie sousCategorie,
  }) async {
    this.url = this.routes['postSousCategorie'].toString(); // set client url
    try {
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.post(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
        body: SousCategorie.toMap(sousCategorie),
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      // ? Show error snack bar
      if (ScreenController.actualView == "SousCategorieView") {
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

  // todo: post moyen de paiement method
  Future<Map<String, dynamic>> postMoyenReglement({
    required var context,
    required MoyenReglement moyenReglement,
  }) async {
    this.url = this.routes['postMoyenReglement'].toString(); // set client url
    try {
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.post(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
        body: MoyenReglement.toMap(moyenReglement),
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: post rayon method
  Future<Map<String, dynamic>> postRayon({
    required var context,
    required Rayon rayon,
  }) async {
    this.url = this.routes['postRayon'].toString(); // set client url
    try {
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.post(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
        body: Rayon.toMap(rayon),
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: post rangee method
  Future<Map<String, dynamic>> postRangee({
    required var context,
    required Rangee rangee,
  }) async {
    this.url = this.routes['postRangee'].toString(); // set client url
    try {
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.post(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
        body: Rangee.toMap(rangee),
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: post casier method
  Future<Map<String, dynamic>> postCasier({
    required var context,
    required Casier casier,
  }) async {
    this.url = this.routes['postCasier'].toString(); // set client url
    try {
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.post(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
        body: Casier.toMap(casier),
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: post unité method
  Future<Map<String, dynamic>> postUnite({
    required var context,
    required Unite unite,
  }) async {
    this.url = this.routes['postUnite'].toString(); // set client url
    try {
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.post(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
        body: Unite.toMap(unite),
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: post taille method
  Future<Map<String, dynamic>> postTaille({
    required var context,
    required Taille taille,
  }) async {
    this.url = this.routes['postTaille'].toString(); // set client url
    try {
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.post(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
        body: Taille.toMap(taille),
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: post divers method
  Future<Map<String, dynamic>> postDivers({
    required var context,
    required Divers divers,
  }) async {
    this.url = this.routes['postDivers'].toString(); // set client url
    try {
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.post(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
        body: Divers.toMap(divers),
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: post catégorie dépense method
  Future<Map<String, dynamic>> postCategorieDepense({
    required var context,
    required CategorieDepense categorieDepense,
  }) async {
    this.url = this.routes['postCategorieDepense'].toString(); // set client url
    try {
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.post(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
        body: CategorieDepense.toMap(categorieDepense),
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: delete banque method
  Future<Map<String, dynamic>> deleteBanque({
    required Banque banque,
  }) async {
    this.url = this.routes['deleteBanque'].toString().replaceAll(
          // ? Replace {id} by true value
          '{id}',
          banque.id.toString(),
        ); // set delete url
    try {
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.delete(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: update banque method
  Future<Map<String, dynamic>> updateBanque({
    required Banque banque,
  }) async {
    this.url = this.routes['updateBanque'].toString().replaceAll(
          // ? Replace {id} by true value
          '{id}',
          banque.id.toString(),
        ); // set update url
    try {
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.put(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
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
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: delete client method
  Future<Map<String, dynamic>> deleteClient({
    required Client client,
  }) async {
    this.url = this.routes['deleteClient'].toString().replaceAll(
          // ? Replace {id} by true value
          '{id}',
          client.id.toString(),
        ); // set delete url
    try {
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.delete(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: update client method
  Future<Map<String, dynamic>> updateClient({
    required Client client,
  }) async {
    this.url = this.routes['updateClient'].toString().replaceAll(
          // ? Replace {id} by true value
          '{id}',
          client.id.toString(),
        ); // set update url
    try {
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.put(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
        body: Client.toMap(client),
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: delete fournisseur method
  Future<Map<String, dynamic>> deleteFournisseur({
    required Fournisseur fournisseur,
  }) async {
    this.url = this.routes['deleteFournisseur'].toString().replaceAll(
          // ? Replace {id} by true value
          '{id}',
          fournisseur.id.toString(),
        ); // set delete url
    try {
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.delete(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: update fournisseur method
  Future<Map<String, dynamic>> updateFournisseur({
    required Fournisseur fournisseur,
  }) async {
    this.url = this.routes['updateFournisseur'].toString().replaceAll(
          // ? Replace {id} by true value
          '{id}',
          fournisseur.id.toString(),
        ); // set update url
    try {
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.put(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
        body: Fournisseur.toMap(fournisseur),
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: delete tva method
  Future<Map<String, dynamic>> deleteTva({
    required Tva tva,
  }) async {
    this.url = this.routes['deleteTva'].toString().replaceAll(
          // ? Replace {id} by true value
          '{id}',
          tva.id.toString(),
        ); // set delete url
    try {
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.delete(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: update tva method
  Future<Map<String, dynamic>> updateTva({
    required Tva tva,
  }) async {
    this.url = this.routes['updateTva'].toString().replaceAll(
          // ? Replace {id} by true value
          '{id}',
          tva.id.toString(),
        ); // set update url
    try {
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.put(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
        body: Tva.toMap(tva),
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: delete regime method
  Future<Map<String, dynamic>> deleteRegime({
    required Regime regime,
  }) async {
    this.url = this.routes['deleteRegime'].toString().replaceAll(
          // ? Replace {id} by true value
          '{id}',
          regime.id.toString(),
        ); // set delete url
    try {
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.delete(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: update regime method
  Future<Map<String, dynamic>> updateRegime({
    required Regime regime,
  }) async {
    this.url = this.routes['updateRegime'].toString().replaceAll(
          // ? Replace {id} by true value
          '{id}',
          regime.id.toString(),
        ); // set update url
    try {
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.put(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
        body: Regime.toMap(regime),
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: delete article method
  Future<Map<String, dynamic>> deleteArticle({
    required Article article,
  }) async {
    this.url = this.routes['deleteArticle'].toString().replaceAll(
          // ? Replace {id} by true value
          '{id}',
          article.id.toString(),
        ); // set delete url
    try {
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.delete(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: update article method
  Future<Map<String, dynamic>> updateArticle({
    required Article article,
  }) async {
    this.url = this.routes['updateArticle'].toString().replaceAll(
          // ? Replace {id} by true value
          '{id}',
          article.id.toString(),
        ); // set update url
    try {
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.put(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
        body: Article.toMap(article),
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: delete caisse method
  Future<Map<String, dynamic>> deleteCaisse({
    required Caisse caisse,
  }) async {
    this.url = this.routes['deleteCaisse'].toString().replaceAll(
          // ? Replace {id} by true value
          '{id}',
          caisse.id.toString(),
        ); // set delete url
    try {
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.delete(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: update caisse method
  Future<Map<String, dynamic>> updateCaisse({
    required Caisse caisse,
  }) async {
    this.url = this.routes['updateCaisse'].toString().replaceAll(
          // ? Replace {id} by true value
          '{id}',
          caisse.id.toString(),
        ); // set update url
    try {
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.put(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
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
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: delete categorie method
  Future<Map<String, dynamic>> deleteCategorie({
    required Categorie categorie,
  }) async {
    this.url = this.routes['deleteCategorie'].toString().replaceAll(
          // ? Replace {id} by true value
          '{id}',
          categorie.id.toString(),
        ); // set delete url
    try {
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.delete(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: update categorie method
  Future<Map<String, dynamic>> updateCategorie({
    required Categorie categorie,
  }) async {
    this.url = this.routes['updateCategorie'].toString().replaceAll(
          // ? Replace {id} by true value
          '{id}',
          categorie.id.toString(),
        ); // set update url
    try {
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.put(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
        body: Categorie.toMap(categorie),
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: delete sousCategorie method
  Future<Map<String, dynamic>> deleteSousCategorie({
    required SousCategorie sousCategorie,
  }) async {
    this.url = this.routes['deleteSousCategorie'].toString().replaceAll(
          // ? Replace {id} by true value
          '{id}',
          sousCategorie.id.toString(),
        ); // set delete url
    try {
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.delete(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: update sousCategorie method
  Future<Map<String, dynamic>> updateSousCategorie({
    required SousCategorie sousCategorie,
  }) async {
    this.url = this.routes['updateSousCategorie'].toString().replaceAll(
          // ? Replace {id} by true value
          '{id}',
          sousCategorie.id.toString(),
        ); // set update url
    try {
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.put(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
        body: SousCategorie.toMap(sousCategorie),
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: delete moyenReglement method
  Future<Map<String, dynamic>> deleteMoyenReglement({
    required MoyenReglement moyenReglement,
  }) async {
    this.url = this.routes['deleteMoyenReglement'].toString().replaceAll(
          // ? Replace {id} by true value
          '{id}',
          moyenReglement.id.toString(),
        ); // set delete url
    try {
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.delete(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: update moyenReglement method
  Future<Map<String, dynamic>> updateMoyenReglement({
    required MoyenReglement moyenReglement,
  }) async {
    this.url = this.routes['updateMoyenReglement'].toString().replaceAll(
          // ? Replace {id} by true value
          '{id}',
          moyenReglement.id.toString(),
        ); // set update url
    try {
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.put(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
        body: MoyenReglement.toMap(moyenReglement),
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: delete rayon method
  Future<Map<String, dynamic>> deleteRayon({
    required Rayon rayon,
  }) async {
    this.url = this.routes['deleteRayon'].toString().replaceAll(
          // ? Replace {id} by true value
          '{id}',
          rayon.id.toString(),
        ); // set delete url
    try {
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.delete(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: update rayon method
  Future<Map<String, dynamic>> updateRayon({
    required Rayon rayon,
  }) async {
    this.url = this.routes['updateRayon'].toString().replaceAll(
          // ? Replace {id} by true value
          '{id}',
          rayon.id.toString(),
        ); // set update url
    try {
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.put(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
        body: Rayon.toMap(rayon),
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: delete rangee method
  Future<Map<String, dynamic>> deleteRangee({
    required Rangee rangee,
  }) async {
    this.url = this.routes['deleteRangee'].toString().replaceAll(
          // ? Replace {id} by true value
          '{id}',
          rangee.id.toString(),
        ); // set delete url
    try {
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.delete(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: update rangee method
  Future<Map<String, dynamic>> updateRangee({
    required Rangee rangee,
  }) async {
    this.url = this.routes['updateRangee'].toString().replaceAll(
          // ? Replace {id} by true value
          '{id}',
          rangee.id.toString(),
        ); // set update url
    try {
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.put(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
        body: Rangee.toMap(rangee),
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: delete casier method
  Future<Map<String, dynamic>> deleteCasier({
    required Casier casier,
  }) async {
    this.url = this.routes['deleteCasier'].toString().replaceAll(
          // ? Replace {id} by true value
          '{id}',
          casier.id.toString(),
        ); // set delete url
    try {
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.delete(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: update casier method
  Future<Map<String, dynamic>> updateCasier({
    required Casier casier,
  }) async {
    this.url = this.routes['updateCasier'].toString().replaceAll(
          // ? Replace {id} by true value
          '{id}',
          casier.id.toString(),
        ); // set update url
    try {
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.put(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
        body: Casier.toMap(casier),
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: delete unite method
  Future<Map<String, dynamic>> deleteUnite({
    required Unite unite,
  }) async {
    this.url = this.routes['deleteUnite'].toString().replaceAll(
          // ? Replace {id} by true value
          '{id}',
          unite.id.toString(),
        ); // set delete url
    try {
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.delete(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: update unite method
  Future<Map<String, dynamic>> updateUnite({
    required Unite unite,
  }) async {
    this.url = this.routes['updateUnite'].toString().replaceAll(
          // ? Replace {id} by true value
          '{id}',
          unite.id.toString(),
        ); // set update url
    try {
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.put(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
        body: Unite.toMap(unite),
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: delete taille method
  Future<Map<String, dynamic>> deleteTaille({
    required Taille taille,
  }) async {
    this.url = this.routes['deleteTaille'].toString().replaceAll(
          // ? Replace {id} by true value
          '{id}',
          taille.id.toString(),
        ); // set delete url
    try {
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.delete(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: update taille method
  Future<Map<String, dynamic>> updateTaille({
    required Taille taille,
  }) async {
    this.url = this.routes['updateTaille'].toString().replaceAll(
          // ? Replace {id} by true value
          '{id}',
          taille.id.toString(),
        ); // set update url
    try {
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.put(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
        body: Taille.toMap(taille),
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: delete divers method
  Future<Map<String, dynamic>> deleteDivers({
    required Divers divers,
  }) async {
    this.url = this.routes['deleteDivers'].toString().replaceAll(
          // ? Replace {id} by true value
          '{id}',
          divers.id.toString(),
        ); // set delete url
    try {
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.delete(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: update divers method
  Future<Map<String, dynamic>> updateDivers({
    required Divers divers,
  }) async {
    this.url = this.routes['updateDivers'].toString().replaceAll(
          // ? Replace {id} by true value
          '{id}',
          divers.id.toString(),
        ); // set update url
    try {
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.put(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
        body: Divers.toMap(divers),
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: delete categorieDepense method
  Future<Map<String, dynamic>> deleteCategorieDepense({
    required CategorieDepense categorieDepense,
  }) async {
    this.url = this.routes['deleteCategorieDepense'].toString().replaceAll(
          // ? Replace {id} by true value
          '{id}',
          categorieDepense.id.toString(),
        ); // set delete url
    try {
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.delete(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: update categorieDepense method
  Future<Map<String, dynamic>> updateCategorieDepense({
    required CategorieDepense categorieDepense,
  }) async {
    this.url = this.routes['updateCategorieDepense'].toString().replaceAll(
          // ? Replace {id} by true value
          '{id}',
          categorieDepense.id.toString(),
        ); // set update url
    try {
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.put(
        Uri.parse(this.url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Charset': 'utf-8',
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
        body: CategorieDepense.toMap(categorieDepense),
      );
      // get and show server response
      final responseJson = json.decode(this.response.body);
      print("Réponse du server: $responseJson");
      print(responseJson.runtimeType);
      return responseJson;
    } catch (error) {
      print(error);
      return {'msg': 'Une erreur est survenue'};
    }
  }

  // todo: Etats ===============================================================
  // Get facture-vente-pdf method
  Future getFactureVentePdf({required int venteId}) async {
    this.url = this.routes['getFactureVentePdf'].toString().replaceAll(
          // ? Replace {id} by true value
          '{vente}',
          venteId.toString(),
        ); // set url
    try {
      // ? getting datas from url
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.get(
        Uri.parse(this.url),
        headers: {
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
      );
      // ? Check the response status code
      if (this.response.statusCode == 200) {
        this.requestSuccess = true;
        //print(this.response.body);
        // ? create list of achatClient
        Map<String, dynamic> pdfJson = json.decode(this.response.body);
        // ? return list of achatClient
        return pdfJson;
      } else {
        this.requestSuccess = false;
        return {'msg': 'no data'};
        //throw Exception('Failed to load user datas');
      }
    } catch (error) {
      print(
          'API ERROR: Get Facture Vente PDF Error -> ${error.runtimeType} -> $error');
      return {'msg': 'Server error'};
    }
  }

  // Get liste-reglement-pdf method
  Future getReglementPdf({required int clientId}) async {
    this.url = this.routes['getReglementPdf'].toString().replaceAll(
          // ? Replace {id} by true value
          '{client}',
          clientId.toString(),
        ); // set url
    try {
      // ? getting datas from url
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.get(
        Uri.parse(this.url),
        headers: {
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
      );
      // ? Check the response status code
      if (this.response.statusCode == 200) {
        this.requestSuccess = true;
        //print(this.response.body);
        // ? create list of achatClient
        Map<String, dynamic> pdfJson = json.decode(this.response.body);
        // ? return list of achatClient
        return pdfJson;
      } else {
        this.requestSuccess = false;
        return {'msg': 'no data'};
        //throw Exception('Failed to load user datas');
      }
    } catch (error) {
      print(
          'API ERROR: Get Reglement PDF Error -> ${error.runtimeType} -> $error');
      return {'msg': 'Server error'};
    }
  }

  // Get liste-articles-plus-achetes-pdf method
  Future getArticlesPlusAchetesPdf({required int clientId}) async {
    this.url = this.routes['getArticlesPlusAchetesPdf'].toString().replaceAll(
          // ? Replace {id} by true value
          '{client}',
          clientId.toString(),
        ); // set url
    try {
      // ? getting datas from url
      print("Actual view -> " + ScreenController.actualView);
      this.response = await http.get(
        Uri.parse(this.url),
        headers: {
          // pass access token into the header
          HttpHeaders.authorizationHeader: Auth.token!,
        },
      );
      // ? Check the response status code
      if (this.response.statusCode == 200) {
        this.requestSuccess = true;
        //print(this.response.body);
        // ? create list of achatClient
        Map<String, dynamic> pdfJson = json.decode(this.response.body);
        // ? return list of achatClient
        return pdfJson;
      } else {
        this.requestSuccess = false;
        return {'msg': 'no data'};
        //throw Exception('Failed to load user datas');
      }
    } catch (error) {
      print(
          'API ERROR: Get ArticlesPlusAchetes PDF Error -> ${error.runtimeType} -> $error');
      return {'msg': 'Server error'};
    }
  }

  // ! End app context methods
}
