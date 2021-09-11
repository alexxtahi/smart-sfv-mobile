class Depot {
  // todo: Properties
  static Depot? depot;
  int id;
  String libelle;
  String adresse;
  String contact;
  // todo: Constructor
  Depot({
    this.id = 0,
    this.libelle = '',
    this.adresse = '',
    this.contact = '',
  });
  // todo: Methods
  // get data from json method
  factory Depot.fromJson(Map<String, dynamic> json) {
    return Depot(
      id: (json['id'] != null) ? json['id'] as int : 0,
      libelle: (json['libelle_depot'] != null)
          ? json['libelle_depot'] as String
          : '',
      adresse: (json['adresse_depot'] != null) ? json['adresse_depot'] : '',
      contact: (json['contact_depot'] != null) ? json['contact_depot'] : '',
    );
  }
  // return to Map
  static Map<String, dynamic> toMap(Depot depot) {
    return <String, dynamic>{
      //'id': categorie.id,
      'libelle_depot': depot.libelle,
      'adresse_depot': depot.adresse,
      'contact_depot': depot.contact,
    };
  }
}
