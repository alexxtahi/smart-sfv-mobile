class Article {
  // todo: Properties
  String codeBarre;
  String description;
  String categorie;
  String subCategorie;
  int qteEnStock;
  int prixAchatTTC;
  int prixAchatHT;
  int prixVenteTTC;
  int prixVenteHT;
  String fournisseur;
  int tva;
  int stockMin;
  String datePeremption;
  String libelleDepot;
  String libelleUnite;
  String datePeremptions;
  // todo: Constructor
  Article({
    this.codeBarre = '',
    this.description = '',
    this.categorie = '',
    this.subCategorie = '',
    this.qteEnStock = 0,
    this.prixAchatTTC = 0,
    this.prixAchatHT = 0,
    this.prixVenteTTC = 0,
    this.prixVenteHT = 0,
    this.fournisseur = '',
    this.tva = 0,
    this.stockMin = 0,
    this.datePeremption = '',
    this.libelleDepot = '',
    this.libelleUnite = '',
    this.datePeremptions = '',
  });
  // todo: Methods
  // get data from json method
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      codeBarre:
          (json['code_barre'] != null) ? json['code_barre'] as String : '',
      description: (json['description_article'] != null)
          ? json['description_article'] as String
          : '',
      categorie: (json['categorie'] != null)
          ? json['categorie']['libelle_categorie'] as String
          : '',
      subCategorie: (json['sous_categorie'] != null)
          ? json['sous_categorie']['libelle_sous_categorie'] as String
          : '',
      qteEnStock: (json['quantite_en_stock'] != null)
          ? json['quantite_en_stock'] as int
          : 0,
      prixAchatTTC:
          (json['prix_achat_ttc'] != null) ? json['prix_achat_ttc'] as int : 0,
      //prixAchatHT: json[''] as int,
      prixVenteTTC: (json['prix_vente_ttc_base'] != null)
          ? json['prix_vente_ttc_base'] as int
          : 0,
      //prixVenteHT: json[''] as int,
      fournisseur:
          (json['fournisseurs'] != null && json['fournisseurs'][0] != null)
              ? json['fournisseurs'][0]['full_name_fournisseur'] as String
              : '',
      //tva: json['param_tva'] as int,
      stockMin: (json['stock_mini'] != null) ? json['stock_mini'] as int : 0,
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
}
