class Client {
  // todo: Properties
  String code;
  String nom;
  String contact;
  String pays;
  String regime;
  String email;
  String adresse;
  String montantPlafond;
  String compteContrib;
  int chiffreAffaire;
  // todo: Constructor
  Client({
    this.code = '',
    this.nom = '',
    this.contact = '',
    this.pays = '',
    this.regime = '',
    this.email = '',
    this.adresse = '',
    this.montantPlafond = '',
    this.compteContrib = '',
    this.chiffreAffaire = 0,
  });
  // todo: Methods
  // get data from json method
  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      code: (json['code_client'] != null) ? json['code_client'] as String : '',
      nom: json['full_name_client'] as String, // ! required
      contact: json['contact_client'] as String, // ! required
      pays: (json['nation'] != null)
          ? json['nation']['libelle_nation'] as String
          : '', // ! required
      regime: (json['regime'] != null)
          ? json['regime']['libelle_regime'] as String
          : '', // ! required
      email:
          (json['email_client'] != null) ? json['email_client'] as String : '',
      adresse: (json['adresse_client'] != null)
          ? json['adresse_client'] as String
          : '',
      montantPlafond: (json['plafond_client'] != null)
          ? json['plafond_client'].toString()
          : '',
      compteContrib: (json['compte_contribuable_client'] != null)
          ? json['compte_contribuable_client'] as String
          : '',
      chiffreAffaire:
          (json['sommeTotale'] != null) ? json['sommeTotale'] as int : 0,
    );
  }
}
