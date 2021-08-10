class Pays {
  // todo: Properties
  int id;
  String libelle;
  // todo: Constructor
  Pays({
    this.id = 0,
    this.libelle = '',
  });
  // todo: Methods
  // get data from json method
  factory Pays.fromJson(Map<String, dynamic> json) {
    return Pays(
      id: (json['id'] != null) ? json['id'] as int : 0,
      libelle: (json['libelle_nation'] != null)
          ? json['libelle_nation'] as String
          : '',
    );
  }

  // return to Map
  static Map<String, dynamic> toMap(Pays pays) {
    return <String, dynamic>{
      //'id': pays.id,
      'libelle_nation': pays.libelle.toString(),
    };
  }
}
