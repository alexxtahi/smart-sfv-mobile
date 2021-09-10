class Rangee {
  // todo: Properties
  static Rangee? rangee;
  int id;
  String libelle;
  // todo: Constructor
  Rangee({
    this.id = 0,
    this.libelle = '',
  });
  // todo: Methods
  // get data from json method
  factory Rangee.fromJson(Map<String, dynamic> json) {
    return Rangee(
      id: (json['id'] != null) ? json['id'] as int : 0,
      libelle: (json['libelle_rangee'] != null)
          ? json['libelle_rangee'] as String
          : '',
    );
  }
  // return to Map
  static Map<String, dynamic> toMap(Rangee categorie) {
    return <String, dynamic>{
      //'id': categorie.id,
      'libelle_rangee': categorie.libelle.toString(),
    };
  }
}
