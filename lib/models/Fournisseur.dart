class Fournisseur {
  // todo: Properties
  int id;
  String code;
  String nom;
  String contact;
  String pays;
  String banque;
  String compteBanque;
  String email;
  String boitePostale;
  String adresse;
  String fax;
  String compteContrib;
  // todo: Constructor
  Fournisseur({
    this.id = 0,
    this.code = '',
    this.nom = '',
    this.contact = '',
    this.pays = '',
    this.banque = '',
    this.compteBanque = '',
    this.email = '',
    this.boitePostale = '',
    this.adresse = '',
    this.fax = '',
    this.compteContrib = '',
  });
  // todo: Methods
  // get data from json method
  factory Fournisseur.fromJson(Map<String, dynamic> json) {
    return Fournisseur(
      id: json['id'] as int,
      code: json['code_fournisseur'].toString(),
      nom: json['full_name_fournisseur'].toString(),
      contact: json['contact_fournisseur'].toString(),
      pays: json['nation']['libelle_nation'].toString(),
      banque: json['banque']['libelle_banque'].toString(),
      compteBanque: json['compte_banque_fournisseur'].toString(),
      email: json['email_fournisseur'].toString(),
      boitePostale: json['boite_postale_fournisseur'].toString(),
      adresse: json['adresse_fournisseur'].toString(),
      fax: json['fax_fournisseur'].toString(),
      compteContrib: json['compte_contribuable_fournisseur'].toString(),
    );
  }
}
