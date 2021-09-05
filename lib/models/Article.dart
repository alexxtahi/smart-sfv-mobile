import 'package:smartsfv/models/Categorie.dart';
import 'package:smartsfv/models/Fournisseur.dart';
import 'package:smartsfv/models/SousCategorie.dart';
import 'package:smartsfv/models/Tva.dart';

class Article {
  // todo: Properties
  int id;
  String codeBarre;
  String description;
  String? designation;
  Categorie categorie;
  SousCategorie? sousCategorie;
  int qteEnStock;
  int totalStock;
  int prixAchatTTC;
  int prixAchatHT;
  int? tauxMargeAchat;
  int prixVenteTTC;
  int prixVenteHT;
  int tauxMargeVente;
  List<Fournisseur> fournisseurs;
  Tva tva;
  int stockMin;
  String datePeremption;
  String libelleDepot;
  String libelleUnite;
  String datePeremptions;
  String? image;
  bool stockable;
  // todo: Constructor
  Article({
    this.id = 0,
    this.codeBarre = '',
    this.description = '',
    this.designation = '',
    required this.categorie,
    this.sousCategorie,
    this.qteEnStock = 0,
    this.totalStock = 0,
    this.prixAchatTTC = 0,
    this.prixAchatHT = 0,
    this.tauxMargeAchat = 0,
    this.prixVenteTTC = 0,
    this.prixVenteHT = 0,
    this.tauxMargeVente = 0,
    this.fournisseurs = const [],
    required this.tva,
    this.stockMin = 0,
    this.datePeremption = '',
    this.libelleDepot = '',
    this.libelleUnite = '',
    this.datePeremptions = '',
    this.image = '',
    this.stockable = true,
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
          ? json['image_article'] as String
          : '',
      stockable:
          (json['stockable'] != null && json['stockable'] == 1) ? true : false,
      datePeremption: (json['date_peremption'] != null)
          ? json['date_peremption']
              .toString()
              .replaceAll('T00:00:00.000000Z', '')
          : '',
      libelleDepot: (json['libelle_depot'] != null)
          ? json['libelle_depot'].toString()
          : '',
      libelleUnite: (json['libelle_unite'] != null)
          ? json['libelle_unite'].toString()
          : '',
      datePeremptions: (json['date_peremptions'] != null)
          ? json['date_peremptions']
              .toString()
              .replaceAll('T00:00:00.000000Z', '')
          : '',
    );
  }
  // return to Map
  static Map<String, dynamic> toMap(Article article) {
    return <String, dynamic>{
      //'id': 0,
      'code_barre': article.codeBarre,
      'designation': article.designation,
      'fournisseur': article.fournisseurs,
      'categorie': article.categorie,
      'subCategorie': article.sousCategorie,
      'stockMin': article.stockMin,
      'tva': article.tva,
      'prixAchatTTC': article.prixAchatTTC,
      'prixAchatHT': article.prixAchatHT,
      'tauxMargeAchat': article.tauxMargeAchat,
      'prixVenteTTC': article.prixVenteTTC,
      'prixVenteHT': article.prixVenteHT,
      'tauxMargeVente': article.tauxMargeVente,
      'image_article': article.image,
      'stockable': article.stockable.toString(),
    };
  }
}
