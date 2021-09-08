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
      id: (json['id'] != null) ? json['id'] as int : 0,
      libelle: (json['libelle_categorie_depense'] != null)
          ? json['libelle_categorie_depense'] as String
          : '',
    );
  }
  // return to Map
  static Map<String, dynamic> toMap(CategorieDepense categorieDepense) {
    return <String, dynamic>{
      //'id': categorieDepense.id,
      'libelle_categorie_depense': categorieDepense.libelle,
    };
  }
}
