class Divers {
  // todo: Properties
  static Divers? divers;
  int id;
  String libelle;
  // todo: Constructor
  Divers({
    this.id = 0,
    this.libelle = '',
  });
  // todo: Methods
  // get data from json method
  factory Divers.fromJson(Map<String, dynamic> json) {
    return Divers(
      id: (json['id'] != null) ? json['id'] as int : 0,
      libelle: (json['libelle_divers'] != null)
          ? json['libelle_divers'] as String
          : '',
    );
  }
  // return to Map
  static Map<String, dynamic> toMap(Divers categorie) {
    return <String, dynamic>{
      //'id': categorie.id,
      'libelle_divers': categorie.libelle,
    };
  }
}
