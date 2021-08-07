class Article {
  // todo: Properties
  String codeBarre;
  String description;
  String categorie;
  int enStock;
  double prixAchatTTC;
  double prixAchatHT;
  double prixVenteTTC;
  double prixVenteHT;
  String fournisseur;
  double tva;
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
      codeBarre: json[''] as String,
      description: json[''] as String,
      categorie: json[''] as String,
      enStock: json[''] as int,
      prixAchatTTC: json[''] as double,
      prixAchatHT: json[''] as double,
      prixVenteTTC: json[''] as double,
      prixVenteHT: json[''] as double,
      fournisseur: json[''] as String,
      tva: json[''] as double,
      stockMin: json[''] as int,
    );
  }
}
