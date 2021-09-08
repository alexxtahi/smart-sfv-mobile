class Regime {
  // todo: Properties
  int id;
  String libelle;
  // todo: Constructor
  Regime({
    this.id = 0,
    this.libelle = '',
  });
  // todo: Methods
  // get data from json method
  factory Regime.fromJson(Map<String, dynamic> json) {
    return Regime(
      id: (json['id'] != null) ? json['id'] as int : 0,
      libelle: (json['libelle_regime'] != null)
          ? json['libelle_regime'] as String
          : '',
    );
  }
  // return to Map
  static Map<String, dynamic> toMap(Regime regime) {
    return <String, dynamic>{
      //'id': regime.id,
      'libelle_regime': regime.libelle,
    };
  }
}
