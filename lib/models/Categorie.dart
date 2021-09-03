class Categorie {
  // todo: Properties
  int id;
  String libelle;
  // todo: Constructor
  Categorie({
    this.id = 0,
    this.libelle = '',
  });
  // todo: Methods
  // get data from json method
  factory Categorie.fromJson(Map<String, dynamic> json) {
    return Categorie(
      id: json['id'] as int,
      libelle: json['libelle_category'] as String,
    );
  }
  // return to Map
  static Map<String, dynamic> toMap(Categorie categorie) {
    return <String, dynamic>{
      //'id': categorie.id,
      'libelle_categorie': categorie.libelle.toString(),
    };
  }
}