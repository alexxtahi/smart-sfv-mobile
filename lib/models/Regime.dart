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
      id: json['id'] as int,
      libelle: json['libelle_regime'] as String,
    );
  }
}
