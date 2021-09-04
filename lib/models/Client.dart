class Client {
  // todo: Properties
  String code;
  String nom;
  String contact;
  String pays;
  String regime;
  String email;
  String adresse;
  String boitePostale;
  String montantPlafond;
  String compteContrib;
  String fax;
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
    this.boitePostale = '',
    this.montantPlafond = '',
    this.compteContrib = '',
    this.fax = '',
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
      boitePostale: (json['boite_postale_client'] != null)
          ? json['boite_postale_client'] as String
          : '',
      montantPlafond: (json['plafond_client'] != null)
          ? json['plafond_client'].toString()
          : '',
      compteContrib: (json['compte_contribuable_client'] != null)
          ? json['compte_contribuable_client'] as String
          : '',
      fax: (json['fax_client'] != null) ? json['fax_client'] as String : '',
      chiffreAffaire:
          (json['sommeTotale'] != null) ? json['sommeTotale'] as int : 0,
    );
  }
  // return to Map
  static Map<String, dynamic> toMap(Client client) {
    return <String, dynamic>{
      //'id': 0,
      'full_name_client': client.nom, // ! required
      'contact_client': client.contact, // ! required
      'email_client': client.email,
      'nation_id': client.pays, // ! required
      'adresse_client': client.adresse,
      'boite_postale_client': client.boitePostale,
      'plafond_client': client.montantPlafond,
      'regime_id': client.regime, // ! required
      'fax_client': client.fax,
      'compte_contribuable_client': client.compteContrib,
    };
  }
}
