class Article {
  // todo: Properties
  String codeBarre;
  String description;
  String categorie;
  int enStock;
  int prixAchatTTC;
  int prixAchatHT;
  int prixVenteTTC;
  int prixVenteHT;
  String fournisseur;
  int tva;
  int stockMin;
  // todo: Constructor
  Article({
    this.codeBarre = '',
    this.description = '',
    this.categorie = '',
    this.enStock = 0,
    this.prixAchatTTC = 0,
    this.prixAchatHT = 0,
    this.prixVenteTTC = 0,
    this.prixVenteHT = 0,
    this.fournisseur = '',
    this.tva = 0,
    this.stockMin = 0,
  });
  // todo: Methods
  // get data from json method
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      codeBarre: json['code_barre'] as String,
      description: json['description_article'] as String,
      categorie: json['categorie']['libelle_categorie'] as String,
      enStock: json['quantite_en_stock'] as int,
      prixAchatTTC: json['prix_achat_ttc'] as int,
      //prixAchatHT: json[''] as int,
      prixVenteTTC: json['prix_vente_ttc_base'] as int,
      //prixVenteHT: json[''] as int,
      fournisseur: json['fournisseurs'][0]['full_name_fournisseur'] as String,
      //tva: json['param_tva'] as int,
      stockMin: json['stock_mini'] as int,
    );
  }
}
