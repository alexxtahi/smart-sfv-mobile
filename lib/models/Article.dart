import 'dart:convert';
import 'dart:io';

import 'package:smartsfv/models/Categorie.dart';
import 'package:smartsfv/models/Depot.dart';
import 'package:smartsfv/models/Fournisseur.dart';
import 'package:smartsfv/models/Rangee.dart';
import 'package:smartsfv/models/Rayon.dart';
import 'package:smartsfv/models/SousCategorie.dart';
import 'package:smartsfv/models/Taille.dart';
import 'package:smartsfv/models/Tva.dart';
import 'package:smartsfv/models/Unite.dart';

class Article {
  // todo: Properties
  static Article? article;
  int id;
  String codeBarre;
  String description;
  Categorie categorie;
  SousCategorie? sousCategorie;
  String referenceInterne;
  int qteEnStock;
  int totalStock;
  int prixAchatTTC;
  int prixAchatHT;
  int? tauxMargeAchat;
  int prixVenteTTC;
  int prixVenteHT;
  int? tauxMargeVente;
  List<Fournisseur> fournisseurs;
  Depot? depot;
  Unite? unite;
  Taille? taille;
  Rayon? rayon;
  Rangee? rangee;
  Tva tva;
  int stockMin;
  int? stockMax;
  String datePeremption;
  String datePeremptions;
  File? image;
  int? poidsNet;
  int? poidsBrut;
  int? volume;

  bool stockable;
  int quantiteAchetee;
  int sommeTotaleAchetee;
  // todo: Constructor
  Article({
    this.id = 0,
    this.codeBarre = '',
    this.description = '',
    required this.categorie,
    this.sousCategorie,
    this.referenceInterne = '',
    this.qteEnStock = 0,
    this.totalStock = 0,
    this.prixAchatTTC = 0,
    this.prixAchatHT = 0,
    this.tauxMargeAchat,
    this.prixVenteTTC = 0,
    this.prixVenteHT = 0,
    this.tauxMargeVente,
    this.fournisseurs = const [],
    required this.tva,
    this.stockMin = 0,
    this.stockMax,
    this.datePeremption = '',
    this.depot,
    this.unite,
    this.taille,
    this.rayon,
    this.rangee,
    this.datePeremptions = '',
    this.poidsNet,
    this.poidsBrut,
    this.volume,
    this.image,
    this.stockable = true,
    this.quantiteAchetee = 0,
    this.sommeTotaleAchetee = 0,
  });
  // todo: Methods
  // get data from json method
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: (json['id'] != null) ? json['id'] as int : 0,
      codeBarre:
          (json['code_barre'] != null) ? json['code_barre'] as String : '',
      description: (json['description_article'] != null)
          ? json['description_article'] as String
          : '',
      categorie: (json['categorie'] != null)
          ? Categorie.fromJson(json['categorie'])
          : Categorie(),
      sousCategorie: (json['sous_categorie'] != null)
          ? SousCategorie.fromJson(json['sous_categorie'])
          : null, // ! nullable
      referenceInterne: (json['reference_interne'] != null)
          ? json['reference_interne'] as String
          : '',
      qteEnStock: (json['quantite_en_stock'] != null)
          ? json['quantite_en_stock'] as int
          : 0,
      totalStock: (json['totalStock'] != null)
          ? int.parse(json['totalStock'].toString())
          : 0,
      prixAchatTTC:
          (json['prix_achat_ttc'] != null) ? json['prix_achat_ttc'] as int : 0,
      //prixAchatHT: json[''] as int,
      prixVenteTTC: (json['prix_vente_ttc_base'] != null)
          ? json['prix_vente_ttc_base'] as int
          : 0,
      //prixVenteHT: json[''] as int,
      fournisseurs:
          (json['fournisseurs'] != null && json['fournisseurs'].isNotEmpty)
              ? [
                  for (var fournisseur in json['fournisseurs'])
                    Fournisseur.fromJson(fournisseur),
                ]
              : [],
      tva:
          (json['param_tva'] != null) ? Tva.fromJson(json['param_tva']) : Tva(),
      stockMin: (json['stock_mini'] != null) ? json['stock_mini'] as int : 0,
      image: (json['image_article'] != null)
          ? File.fromRawPath(base64.decode(json['image_article']))
          : null,
      stockable: (json['stockable'] != null &&
              (json['stockable'] == 1 ||
                  json['stockable'] == '1' ||
                  json['stockable'] == true))
          ? true
          : false,
      datePeremption: (json['date_peremption'] != null)
          ? json['date_peremption']
              .toString()
              .replaceAll('T00:00:00.000000Z', '')
          : '',
      depot: (json['libelle_depot'] != null)
          ? Depot.fromJson({'libelle_depot': json['libelle_depot']})
          : Depot(libelle: 'Aucun'),
      unite: (json['unite'] != null) ? Unite.fromJson(json['unite']) : Unite(),
      taille:
          (json['taille'] != null) ? Taille.fromJson(json['taille']) : Taille(),
      rayon: (json['rayon'] != null) ? Rayon.fromJson(json['rayon']) : Rayon(),
      rangee:
          (json['rangee'] != null) ? Rangee.fromJson(json['rangee']) : Rangee(),
      datePeremptions: (json['date_peremptions'] != null)
          ? json['date_peremptions']
              .toString()
              .replaceAll('T00:00:00.000000Z', '')
          : '',
      quantiteAchetee:
          (json['qteTotale'] != null) ? json['qteTotale'] as int : 0,
      sommeTotaleAchetee:
          (json['sommeTotale'] != null) ? json['sommeTotale'] as int : 0,
    );
  }
  // get data from instance method
  factory Article.fromInstance(Article article) {
    return Article(
      id: article.id,
      codeBarre: article.codeBarre,
      description: article.description,
      categorie: article.categorie,
      sousCategorie: article.sousCategorie, // ! nullable
      referenceInterne: article.referenceInterne,
      qteEnStock: article.qteEnStock,
      totalStock: article.sommeTotaleAchetee,
      prixAchatTTC: article.sommeTotaleAchetee,
      //prixAchatHT: json[''] as int,
      prixVenteTTC: article.sommeTotaleAchetee,
      //prixVenteHT: json[''] as int,
      fournisseurs: article.fournisseurs,
      tva: article.tva,
      stockMin: article.sommeTotaleAchetee,
      image: article.image,
      stockable: article.stockable,
      datePeremption: article.datePeremption,
      depot: article.depot,
      unite: article.unite,
      datePeremptions: article.datePeremptions,
      quantiteAchetee: article.quantiteAchetee,
      sommeTotaleAchetee: article.sommeTotaleAchetee,
    );
  }
  // return to Map
  static Map<String, dynamic> toMap(Article article) {
    return <String, dynamic>{
      //'id': 0,
      'code_barre': article.codeBarre,
      'description_article': article.description,
      if (article.fournisseurs.isNotEmpty)
        'fournisseurs': [
          for (var fournisseur in article.fournisseurs)
            fournisseur.id.toString(),
        ].toString(),
      'categorie_id': article.categorie.id.toString(),
      'prix_achat_ttc': article.prixAchatTTC.toString(),
      'prix_vente_ttc_base': article.prixVenteTTC.toString(),

      if (article.sousCategorie != null)
        'sous_categorie_id': article.sousCategorie!.id.toString(),
      if (article.referenceInterne != '')
        'reference_interne': article.referenceInterne,
      if (article.unite != null) 'unite_id': article.unite!.id.toString(),
      if (article.taille != null) 'taille_id': article.taille!.id.toString(),
      if (article.rayon != null) 'rayon_id': article.rayon!.id.toString(),
      if (article.rangee != null) 'rangee_id': article.rangee!.id.toString(),
      'param_tva_id': article.tva.id.toString(),
      if (article.tauxMargeAchat != null)
        'taux_airsi_achat': article.tauxMargeAchat!.toString(),
      if (article.tauxMargeVente != null)
        'taux_airsi_vente': article.tauxMargeVente!.toString(),
      if (article.poidsNet != null) 'poids_net': article.poidsNet!.toString(),
      if (article.poidsBrut != null)
        'poids_Brut': article.poidsBrut!.toString(),
      'stockMin': article.stockMin.toString(),
      if (article.stockMax != null) 'stock_max': article.stockMax!.toString(),
      if (article.volume != null) 'volume': article.volume!.toString(),
      'tva': article.tva.toString(),
      if (article.image != null)
        'image_article': base64.encode(article.image!.readAsBytesSync()),
      if (article.stockable == false) 'stockable': article.stockable.toString(),
    };
  }
}
