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
      id: json['id'] as int,
      libelle: json['libelle_casier'] as String,
    );
  }
  // return to Map
  static Map<String, dynamic> toMap(Casier categorie) {
    return <String, dynamic>{
      //'id': categorie.id,
      'libelle_casier': categorie.libelle.toString(),
    };
  }
}
