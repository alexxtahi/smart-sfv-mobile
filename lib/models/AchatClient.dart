import 'package:intl/intl.dart';
import 'package:smartsfv/models/Caisse.dart';
import 'package:smartsfv/models/Client.dart';
import 'package:smartsfv/models/Depot.dart';
import 'package:smartsfv/models/Remise.dart';

class AchatClient {
  // todo: Properties
  static AchatClient? achatClient;
  int id;
  String numeroFacture;
  String numeroTicket;
  DateTime dateVente;
  Depot depot;
  Client client;
  Caisse? caisseOuverte;
  int acompteFacture;
  int montantAPayer;
  int montantPayer;
  int reste;
  Remise? remise;
  bool proformat;
  bool attente;
  bool divers;
  int sommeTotale;
  int sommeRemise;
  DateTime dateVentes;
  static int totalAchat = 0;
  static int totalAcompte = 0;
  static int totalRemise = 0;
  // todo: Constructor
  AchatClient({
    this.id = 0,
    this.numeroFacture = '',
    this.numeroTicket = '',
    required this.dateVente,
    required this.depot,
    required this.client,
    this.caisseOuverte,
    this.acompteFacture = 0,
    this.montantAPayer = 0,
    this.montantPayer = 0,
    this.reste = 0,
    this.remise,
    this.proformat = false,
    this.attente = false,
    this.divers = false,
    this.sommeTotale = 0,
    this.sommeRemise = 0,
    required this.dateVentes,
  });
  // todo: Methods
  // get data from json method
  factory AchatClient.fromJson(Map<String, dynamic> json) {
    return AchatClient(
      id: (json['id'] != null) ? json['id'] as int : 0,
      numeroFacture: (json['numero_facture'] != null)
          ? json['numero_facture'] as String
          : '',
      numeroTicket: (json['numero_ticket'] != null)
          ? json['numero_ticket'] as String
          : '',
      dateVente: (json['date_vente'] != null)
          ? DateTime.parse(json['date_vente'])
          : DateTime.now(),
      depot: (json['depot'] != null) ? Depot.fromJson(json['depot']) : Depot(),
      client: (json['client'] != null)
          ? Client.fromJson(json['client'])
          : Client.fromJson({}),
      caisseOuverte: (json['caisse_ouverte'] != null)
          ? Caisse.fromJson(json['caisse_ouverte'])
          : null,
      acompteFacture:
          (json['acompte_facture'] != null && json['acompte_facture'] == 1)
              ? json['acompte_facture'] as int
              : 0,
      montantAPayer: (json['montant_a_payer'] != null)
          ? json['montant_a_payer'] as int
          : 0,
      montantPayer:
          (json['montant_payer'] != null) ? json['montant_payer'] as int : 0,
      reste: (json['sommeRemise'] != null && json['sommeTotale'] != null)
          ? (int.parse(json['sommeTotale'].toString()) -
              int.parse(json['sommeRemise'].toString()))
          : 0,
      remise: (json['remise'] != null) ? Remise.fromJson(json['remise']) : null,
      proformat:
          (json['proformat'] != null && json['proformat'] == 1) ? true : false,
      attente: (json['attente'] != null && json['attente'] == 1) ? true : false,
      divers: (json['divers'] != null && json['divers'] == 1) ? true : false,
      sommeTotale: (json['sommeTotale'] != null)
          ? int.parse(json['sommeTotale'].toString())
          : 0,
      sommeRemise: (json['sommeRemise'] != null)
          ? int.parse(json['sommeRemise'].toString())
          : 0,
      dateVentes: (json['date_ventes'] != null)
          ? DateFormat('dd-MM-yyyy').parse(json['date_ventes'])
          : DateTime.now(),
    );
  }
  // return to Map
  static Map<String, dynamic> toMap(AchatClient achatClient) {
    return <String, dynamic>{
      //'id': 0,
      'numero_facture': achatClient.numeroFacture,
      'numero_ticket': achatClient.numeroTicket,
      'date_vente':
          DateFormat('yyy-mm-dd HH:mm:ss').format(achatClient.dateVente),
      'depot_id': achatClient.depot.id,
      'client_id': achatClient.client.id,
      'caisse_ouverte_id': achatClient.caisseOuverte!.id,
      'acompte_facture': achatClient.acompteFacture,
      'montant_a_payer': achatClient.montantAPayer,
      'montant_payer': achatClient.montantPayer,
      'remise_id': achatClient.remise!.id,
      'proformat': (achatClient.proformat) ? '1' : '0',
      'attente': (achatClient.attente) ? '1' : '0',
      'divers': (achatClient.divers) ? '1' : '0',
      'sommeTotale': achatClient.sommeTotale,
      'sommeRemise': achatClient.sommeRemise,
      'date_ventes':
          DateFormat('yyy-mm-dd HH:mm:ss').format(achatClient.dateVentes),
    };
  }
}
