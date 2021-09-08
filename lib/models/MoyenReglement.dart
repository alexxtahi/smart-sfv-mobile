class MoyenReglement {
  // todo: Properties
  int id;
  String libelle;
  // todo: Constructor
  MoyenReglement({
    this.id = 0,
    this.libelle = '',
  });
  // todo: Methods
  // get data from json method
  factory MoyenReglement.fromJson(Map<String, dynamic> json) {
    return MoyenReglement(
      id: (json['id'] != null) ? json['id'] as int : 0,
      libelle: (json['libelle_moyen_reglement'] != null)
          ? json['libelle_moyen_reglement'] as String
          : '',
    );
  }
  // return to Map
  static Map<String, dynamic> toMap(MoyenReglement categorie) {
    return <String, dynamic>{
      //'id': categorie.id,
      'libelle_moyen_reglement': categorie.libelle,
    };
  }
}
