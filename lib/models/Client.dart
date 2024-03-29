import 'package:smartsfv/models/Pays.dart';
import 'package:smartsfv/models/Regime.dart';

class Client {
  // todo: Properties
  static Client? client;
  int id;
  String code;
  String nom;
  String contact;
  Pays pays;
  Regime regime;
  String email;
  String adresse;
  String boitePostale;
  String montantPlafond;
  String compteContrib;
  String fax;
  int chiffreAffaire;
  // todo: Constructor
  Client({
    this.id = 0,
    this.code = '',
    this.nom = '',
    this.contact = '',
    required this.pays,
    required this.regime,
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
      id: (json['id'] != null) ? json['id'] : 0,
      code: (json['code_client'] != null)
          ? json['code_client'] as String
          : 'Aucun',
      nom: json['full_name_client'] as String, // ! required
      contact: json['contact_client'] as String, // ! required
      pays: (json['nation'] != null)
          ? Pays.fromJson(json['nation'])
          : Pays(libelle: "Aucun"), // ! required
      regime: (json['regime'] != null)
          ? Regime.fromJson(json['regime'])
          : Regime(libelle: "Aucun"), // ! required
      email: (json['email_client'] != null)
          ? json['email_client'] as String
          : 'Aucune',
      adresse: (json['adresse_client'] != null)
          ? json['adresse_client'] as String
          : 'Aucune',
      boitePostale: (json['boite_postale_client'] != null)
          ? json['boite_postale_client'] as String
          : 'Aucune',
      montantPlafond: (json['plafond_client'] != null)
          ? json['plafond_client'].toString()
          : 'Aucun',
      compteContrib: (json['compte_contribuable_client'] != null)
          ? json['compte_contribuable_client'] as String
          : 'Aucun',
      fax:
          (json['fax_client'] != null) ? json['fax_client'] as String : 'Aucun',
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
      'nation_id': client.pays.id.toString(), // ! required
      'adresse_client': client.adresse,
      'boite_postale_client': client.boitePostale,
      'plafond_client': client.montantPlafond,
      'regime_id': client.regime.id.toString(), // ! required
      'fax_client': client.fax,
      'compte_contribuable_client': client.compteContrib,
    };
  }

  // get data from instance method
  factory Client.fromInstance(Client? client) {
    return (client != null)
        ? Client(
            id: client.id,
            code: client.code,
            nom: client.nom, // ! required
            contact: client.contact, // ! required
            pays: client.pays, // ! required
            regime: client.regime, // ! required
            email: client.email,
            adresse: client.adresse,
            boitePostale: client.boitePostale,
            montantPlafond: client.montantPlafond,
            compteContrib: client.compteContrib,
            fax: client.fax,
            chiffreAffaire: client.chiffreAffaire,
          )
        : Client.fromJson({});
  }
}
