class Commande {
  // todo: Properties
  int id;
  String date;
  int numeroBon;
  String fournisseur;
  int montant;
  // todo: Constructor
  Commande({
    this.id = 0,
    this.fournisseur = '',
    this.date = '',
    this.numeroBon = 0,
    this.montant = 0,
  });
  // todo: Methods
  // get data from json method
  factory Commande.fromJson(Map<String, dynamic> json) {
    return Commande(
      id: (json['id'] != null) ? json['id'] as int : 0,
      fournisseur:
          (json['fournisseurs'] != null && json['fournisseurs'].isNotEmpty)
              ? json['fournisseurs']['full_name_fournisseur'] as String
              : '',
      date: (json['date_commande'] != null)
          ? json['date_commande'] as String
          : '',
      numeroBon: (json['numeroBon'] != null) ? json['numeroBon'] as int : 0,
      montant: (json['montant'] != null) ? json['montant'] as int : 0,
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
