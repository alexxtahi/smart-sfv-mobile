class Client {
  // todo: Properties
  String code;
  String nom;
  String contact;
  String pays;
  String regime;
  String email;
  String adresse;
  int montantPlafond;
  String compteContrib;
  // todo: Constructor
  Client({
    this.code = '',
    this.nom = '',
    this.contact = '',
    this.pays = '',
    this.regime = '',
    this.email = '',
    this.adresse = '',
    this.montantPlafond = 0,
    this.compteContrib = '',
  });
  // todo: Methods
  // get data from json method
  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      code: json['code_client'] as String,
      nom: json['full_name_client'] as String,
      contact: json['contact_client'] as String,
      pays: json['nation']['libelle_nation'] as String,
      regime: json['regime']['libelle_regime'] as String,
      email: json['email_client'] as String,
      adresse: json['adresse_client'] as String,
      montantPlafond: json['plafond_client'] as int,
      compteContrib: json['compte_contribuable_client'] as String,
    );
  }
}
