class Caisse {
  // todo: Properties
  int id;
  String libelle;
  String depot;
  // todo: Constructor
  Caisse({
    this.id = 0,
    this.libelle = '',
    this.depot = '',
  });
  // todo: Methods
  // get data from json method
  factory Caisse.fromJson(Map<String, dynamic> json) {
    return Caisse(
      id: (json['id'] != null) ? json['id'] as int : 0,
      libelle: (json['libelle_banque'] != null)
          ? json['libelle_banque'] as String
          : '',
      depot: (json['libelle_depot'] != null)
          ? json['libelle_depot'] as String
          : '',
    );
  }

  // return to Map
  static Map<String, dynamic> toMap(Caisse caisse) {
    return <String, dynamic>{
      //'id': caisse.id,
      'libelle_caisse': caisse.libelle.toString(),
      'depot_id': caisse.depot.toString(),
    };
  }
}
