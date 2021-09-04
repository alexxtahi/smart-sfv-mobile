class Rayon {
  // todo: Properties
  int id;
  String libelle;
  // todo: Constructor
  Rayon({
    this.id = 0,
    this.libelle = '',
  });
  // todo: Methods
  // get data from json method
  factory Rayon.fromJson(Map<String, dynamic> json) {
    return Rayon(
      id: json['id'] as int,
      libelle: json['libelle_rayon'] as String,
    );
  }
  // return to Map
  static Map<String, dynamic> toMap(Rayon categorie) {
    return <String, dynamic>{
      //'id': categorie.id,
      'libelle_rayon': categorie.libelle.toString(),
    };
  }
}
