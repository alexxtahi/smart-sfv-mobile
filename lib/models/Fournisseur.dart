class Fournisseur {
  // todo: Properties
  int? id;
  String? code;
  String? nom;
  String? contact;
  String? pays;
  String? banque;
  String? compteBanque;
  String? email;
  String? boitePostale;
  String? adresse;
  String? fax;
  String? compteContrib;
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
      id: (json['id'] != null) ? json['id'] as int : 0,
      code: (json['code_fournisseur'] != null)
          ? json['code_fournisseur'].toString()
          : '',
      nom: (json['full_name_fournisseur'] != null)
          ? json['full_name_fournisseur'].toString()
          : '',
      contact: (json['contact_fournisseur'] != null)
          ? json['contact_fournisseur'].toString()
          : '',
      pays: (json['nation'] != null)
          ? json['nation']['libelle_nation'].toString()
          : '',
      banque: (json['banque'] != null)
          ? json['banque']['libelle_banque'].toString()
          : '',
      compteBanque: (json['compte_banque_fournisseur'] != null)
          ? json['compte_banque_fournisseur'].toString()
          : '',
      email: (json['email_fournisseur'] != null)
          ? json['email_fournisseur'].toString()
          : '',
      boitePostale: (json['boite_postale_fournisseur'] != null)
          ? json['boite_postale_fournisseur'].toString()
          : '',
      adresse: (json['adresse_fournisseur'] != null)
          ? json['adresse_fournisseur'].toString()
          : '',
      fax: (json['fax_fournisseur'] != null)
          ? json['fax_fournisseur'].toString()
          : '',
      compteContrib: (json['compte_contribuable_fournisseur'] != null)
          ? json['compte_contribuable_fournisseur'].toString()
          : '',
    );
  }
  // return to Map
  static Map<String, dynamic> toMap(Fournisseur fournisseur) {
    return <String, dynamic>{
      //'id': fournisseur.id,
      //'code_fournisseur': fournisseur.code.toString(),
      'full_name_fournisseur': fournisseur.nom.toString(),
      'contact_fournisseur': fournisseur.contact.toString(),
      'nation_id': fournisseur.pays.toString(),
      'banque_id': fournisseur.banque.toString(),
      'compte_banque_fournisseur': fournisseur.compteBanque.toString(),
      'email_fournisseur': fournisseur.email.toString(),
      'boite_postale_fournisseur': fournisseur.boitePostale.toString(),
      'adresse_fournisseur': fournisseur.adresse.toString(),
      'fax_fournisseur': fournisseur.fax.toString(),
      'compte_contribuable_fournisseur': fournisseur.compteContrib.toString(),
    };
  }
}
