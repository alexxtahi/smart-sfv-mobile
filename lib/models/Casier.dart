class Casier {
  // todo: Properties
  int id;
  String libelle;
  // todo: Constructor
  Casier({
    this.id = 0,
    this.libelle = '',
  });
  // todo: Methods
  // get data from json method
  factory Casier.fromJson(Map<String, dynamic> json) {
    return Casier(
      id: (json['id'] != null) ? json['id'] as int : 0,
      libelle: (json['libelle_casier'] != null)
          ? json['libelle_casier'] as String
          : '',
    );
  }
  // return to Map
  static Map<String, dynamic> toMap(Casier casier) {
    return <String, dynamic>{
      //'id': casier.id,
      'libelle_casier': casier.libelle,
    };
  }
}
