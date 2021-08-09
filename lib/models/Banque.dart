class Banque {
  // todo: Properties
  int id;
  String libelle;
  // todo: Constructor
  Banque({
    this.id = 0,
    this.libelle = '',
  });
  // todo: Methods
  // get data from json method
  factory Banque.fromJson(Map<String, dynamic> json) {
    return Banque(
      id: json['id'] as int,
      libelle: json['libelle_banque'] as String,
    );
  }
}
