class Rayon {
  // todo: Properties
  static Rayon? rayon;
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
      id: (json['id'] != null) ? json['id'] as int : 0,
      libelle: (json['libelle_rayon'] != null)
          ? json['libelle_rayon'] as String
          : '',
    );
  }
  // return to Map
  static Map<String, dynamic> toMap(Rayon rayon) {
    return <String, dynamic>{
      //'id': rayon.id,
      'libelle_rayon': rayon.libelle,
    };
  }
}
