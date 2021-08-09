class Tva {
  // todo: Properties
  int id;
  String libelle;
  // todo: Constructor
  Tva({
    this.id = 0,
    this.libelle = '',
  });
  // todo: Methods
  // get data from json method
  factory Tva.fromJson(Map<String, dynamic> json) {
    return Tva(
      id: json['id'] as int,
      libelle: json['libelle_tva'] as String,
    );
  }
}
