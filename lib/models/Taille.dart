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
      id: (json['id'] != null) ? json['id'] as int : 0,
      libelle: (json['libelle_taille'] != null)
          ? json['libelle_taille'] as String
          : '',
    );
  }
  // return to Map
  static Map<String, dynamic> toMap(Taille taille) {
    return <String, dynamic>{
      //'id': taille.id,
      'libelle_taille': taille.libelle,
    };
  }
}
