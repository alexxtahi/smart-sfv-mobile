class Taille {
  // todo: Properties
  int id;
  String libelle;
  // todo: Constructor
  Taille({
    this.id = 0,
    this.libelle = '',
  });
  // todo: Methods
  // get data from json method
  factory Taille.fromJson(Map<String, dynamic> json) {
    return Taille(
      id: json['id'] as int,
      libelle: json['libelle_taille'] as String,
    );
  }
  // return to Map
  static Map<String, dynamic> toMap(Taille categorie) {
    return <String, dynamic>{
      //'id': categorie.id,
      'libelle_taille': categorie.libelle.toString(),
    };
  }
}
