class CategorieDepense {
  // todo: Properties
  int id;
  String libelle;
  // todo: Constructor
  CategorieDepense({
    this.id = 0,
    this.libelle = '',
  });
  // todo: Methods
  // get data from json method
  factory CategorieDepense.fromJson(Map<String, dynamic> json) {
    return CategorieDepense(
      id: json['id'] as int,
      libelle: json['libelle_categorie_depense'] as String,
    );
  }
  // return to Map
  static Map<String, dynamic> toMap(CategorieDepense categorie) {
    return <String, dynamic>{
      //'id': categorie.id,
      'libelle_categorie_depense': categorie.libelle.toString(),
    };
  }
}
