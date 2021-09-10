import 'package:smartsfv/models/Depot.dart';

class Caisse {
  // todo: Properties
  static Caisse? caisse;
  int id;
  String libelle;
  Depot depot;
  // todo: Constructor
  Caisse({
    this.id = 0,
    this.libelle = '',
    required this.depot,
  });
  // todo: Methods
  // get data from json method
  factory Caisse.fromJson(Map<String, dynamic> json) {
    return Caisse(
      id: (json['id'] != null) ? json['id'] as int : 0,
      libelle: (json['libelle_caisse'] != null)
          ? json['libelle_caisse'] as String
          : '',
      depot: (json['depot'] != null) ? Depot.fromJson(json['depot']) : Depot(),
    );
  }

  // return to Map
  static Map<String, dynamic> toMap(Caisse caisse) {
    return <String, dynamic>{
      //'id': caisse.id,
      'libelle_caisse': caisse.libelle,
      'depot_id': caisse.depot.id.toString(),
    };
  }
}
