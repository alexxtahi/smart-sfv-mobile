class MoyenPayement {
  // todo: Properties
  int id;
  String libelle;
  // todo: Constructor
  MoyenPayement({
    this.id = 0,
    this.libelle = '',
  });
  // todo: Methods
  // get data from json method
  factory MoyenPayement.fromJson(Map<String, dynamic> json) {
    return MoyenPayement(
      id: json['id'] as int,
      libelle: json['libelle_moyen_payement'] as String,
    );
  }
  // return to Map
  static Map<String, dynamic> toMap(MoyenPayement categorie) {
    return <String, dynamic>{
      //'id': categorie.id,
      'libelle_moyen_payement': categorie.libelle.toString(),
    };
  }
}
