class Vente {
  // todo: Properties
  static Vente? unite;
  int id;
  String libelle;
  int qte;
  // todo: Constructor
  Vente({
    this.id = 0,
    required this.libelle,
    required this.qte,
  });
  // todo: Methods
  // get data from json method
  factory Vente.fromJson(Map<String, dynamic> json) {
    return Vente(
      id: (json['id'] != null) ? json['id'] as int : 0,
      libelle: (json['libelle_unite'] != null)
          ? json['libelle_unite'] as String
          : '',
      qte: (json['quantite_unite'] != null) ? json['quantite_unite'] as int : 0,
    );
  }
  // return to Map
  static Map<String, dynamic> toMap(Vente unite) {
    return <String, dynamic>{
      //'id': unite.id,
      'libelle_unite': unite.libelle,
      'quantite_unite': unite.qte.toString(),
    };
  }
}
