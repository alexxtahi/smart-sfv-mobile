import 'package:smartsfv/models/Categorie.dart';

class SousCategorie {
  // todo: Properties
  int id;
  String libelle;
  Categorie categorie;
  // todo: Constructor
  SousCategorie({
    this.id = 0,
    required this.libelle,
    required this.categorie,
  });
  // todo: Methods
  // get data from json method
  factory SousCategorie.fromJson(Map<String, dynamic> json) {
    return SousCategorie(
      id: json['id'] as int,
      libelle: json['libelle_SousCategorie'] as String,
      categorie: Categorie.fromJson(json['categorie']),
    );
  }
  // return to Map
  static Map<String, dynamic> toMap(SousCategorie sousCategorie) {
    return <String, dynamic>{
      //'id': categorie.id,
      'libelle_sous_categorie': sousCategorie.libelle.toString(),
      'categorie_id': sousCategorie.categorie.id,
    };
  }
}
