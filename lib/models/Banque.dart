class Banque {
  // todo: Properties
  static Banque? banque;
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
      id: (json['id'] != null) ? json['id'] as int : 0,
      libelle: (json['libelle_banque'] != null)
          ? json['libelle_banque'] as String
          : '',
    );
  }

  // return to Map
  static Map<String, dynamic> toMap(Banque banque) {
    return <String, dynamic>{
      //'id': banque.id,
      'libelle_banque': banque.libelle,
    };
  }
}
