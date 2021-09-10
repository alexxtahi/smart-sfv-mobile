import 'package:smartsfv/models/Categorie.dart';

class SousCategorie {
  // todo: Properties
  static SousCategorie? sousCategorie;
  int id;
  String libelle;
  Categorie categorie;
  // todo: Constructor
  SousCategorie({
    this.id = 0,
    this.libelle = '',
    required this.categorie,
  });
  // todo: Methods
  // get data from json method
  factory SousCategorie.fromJson(Map<String, dynamic> json) {
    return SousCategorie(
      id: (json['id'] != null) ? json['id'] as int : 0,
      libelle: (json['libelle_sous_categorie'] != null)
          ? json['libelle_sous_categorie'] as String
          : '',
      categorie: (json['categorie'] != null)
          ? Categorie.fromJson(json['categorie'])
          : Categorie(),
    );
  }
  // return to Map
  static Map<String, dynamic> toMap(SousCategorie sousCategorie) {
    return <String, dynamic>{
      //'id': categorie.id,
      'libelle_sous_categorie': sousCategorie.libelle,
      'categorie_id': sousCategorie.categorie.id.toString(),
    };
  }
}
