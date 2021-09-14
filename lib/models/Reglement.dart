import 'package:intl/intl.dart';
import 'package:smartsfv/models/Caisse.dart';
import 'package:smartsfv/models/Commande.dart';
import 'package:smartsfv/models/MoyenReglement.dart';
import 'package:smartsfv/models/Vente.dart';

class Reglement {
  // todo: Properties
  static Reglement? achatClient;
  int id;
  int montant;
  int reste;
  MoyenReglement moyenReglement;
  DateTime date;
  Caisse caisse;
  Commande commande;
  Vente vente;
  String objet;
  String scanCheque;
  String numeroChequeVirement;
  // todo: Constructor
  Reglement({
    this.id = 0,
    this.montant = 0,
    this.reste = 0,
    required this.moyenReglement,
    required this.date,
    required this.caisse,
    required this.commande,
    required this.vente,
    this.objet = '',
    this.scanCheque = '',
    this.numeroChequeVirement = '',
  });
  // todo: Methods
  // get data from json method
  factory Reglement.fromJson(Map<String, dynamic> json) {
    return Reglement(
      id: (json['id'] != null) ? json['id'] as int : 0,
      montant: (json['montant_reglement'] != null)
          ? json['montant_reglement'] as int
          : 0,
      reste: (json['reste_a_payer'] != null) ? json['reste_a_payer'] as int : 0,
      moyenReglement: (json['moyen_reglement'] != null)
          ? MoyenReglement.fromJson(json['moyen_reglement'])
          : MoyenReglement(),
      date: (json['date_reglement'] != null)
          ? DateFormat('dd-MM-yyyy').parse(json['date_reglement'])
          : DateTime.now(),
      caisse: (json['caisse_ouverte'] != null)
          ? Caisse.fromJson(json['caisse_ouverte'])
          : Caisse.fromJson({}),
      commande: (json['commande'] != null)
          ? Commande.fromJson(json['commande'])
          : Commande.fromJson({}),
      vente: (json['vente'] != null)
          ? Vente.fromJson(json['vente'])
          : Vente.fromJson({}),
      objet: (json['objet'] != null) ? json['objet'] as String : '',
      scanCheque:
          (json['scan_cheque'] != null) ? json['scan_cheque'] as String : '',
      numeroChequeVirement: (json['numero_cheque_virement'] != null)
          ? json['numero_cheque_virement'] as String
          : '',
    );
  }
  // return to Map
  static Map<String, dynamic> toMap(Reglement achatClient) {
    return <String, dynamic>{
      'id': 0,
    };
  }
}
