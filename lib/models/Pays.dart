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
      id: json['id'] as int,
      libelle: json['libelle_nation'] as String,
    );
  }
}
