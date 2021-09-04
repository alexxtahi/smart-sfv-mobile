class Unite {
  // todo: Properties
  int id;
  String libelle;
  int qte;
  // todo: Constructor
  Unite({
    this.id = 0,
    required this.libelle,
    required this.qte,
  });
  // todo: Methods
  // get data from json method
  factory Unite.fromJson(Map<String, dynamic> json) {
    return Unite(
      id: json['id'] as int,
      libelle: json['libelle_unite'] as String,
      qte: json['qte_lot'] as int,
    );
  }
  // return to Map
  static Map<String, dynamic> toMap(Unite unite) {
    return <String, dynamic>{
      //'id': unite.id,
      'libelle_unite': unite.libelle.toString(),
      'qte_lot': unite.qte,
    };
  }
}
