class Divers {
  // todo: Properties
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
      id: json['id'] as int,
      libelle: json['libelle_divers'] as String,
    );
  }
  // return to Map
  static Map<String, dynamic> toMap(Divers categorie) {
    return <String, dynamic>{
      //'id': categorie.id,
      'libelle_divers': categorie.libelle.toString(),
    };
  }
}
