class Commande {
  // todo: Properties
  static Commande? commande;
  int id;
  String date;
  String numeroBon;
  String fournisseur;
  int montant;
  // todo: Constructor
  Commande({
    this.id = 0,
    this.fournisseur = '',
    this.date = '',
    this.numeroBon = '',
    this.montant = 0,
  });
  // todo: Methods
  // get data from json method
  factory Commande.fromJson(Map<String, dynamic> json) {
    return Commande(
      id: (json['id'] != null) ? json['id'] as int : 0,
      fournisseur:
          (json['fournisseur'] != null && json['fournisseur'].isNotEmpty)
              ? json['fournisseur']['full_name_fournisseur'] as String
              : '',
      date: (json['date_bon_commande'] != null)
          ? json['date_bon_commande']
              .toString()
              .replaceAll('T', ' ')
              .replaceAll('.000000Z', '')
          : '',
      numeroBon:
          (json['numero_bon'] != null) ? json['numero_bon'] as String : '',
      montant: (json['montantBon'] != null) ? json['montantBon'] as int : 0,
    );
  }

  // return to Map
  static Map<String, dynamic> toMap(Commande banque) {
    return <String, dynamic>{
      //'id': banque.id,
      'fournisseur_commande': banque.fournisseur.toString(),
    };
  }
}
