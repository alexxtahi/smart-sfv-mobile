class Remise {
  // todo: Properties
  static Remise? remise;
  int id;
  String libelle;
  // todo: Constructor
  Remise({
    this.id = 0,
    this.libelle = '',
  });
  // todo: Methods
  // get data from json method
  factory Remise.fromJson(Map<String, dynamic> json) {
    return Remise(
      id: (json['id'] != null) ? json['id'] as int : 0,
      libelle: (json['libelle_remise'] != null)
          ? json['libelle_remise'] as String
          : '',
    );
  }
  // return to Map
  static Map<String, dynamic> toMap(Remise remise) {
    return <String, dynamic>{
      //'id': remise.id,
      'libelle_remise': remise.libelle,
    };
  }
}
