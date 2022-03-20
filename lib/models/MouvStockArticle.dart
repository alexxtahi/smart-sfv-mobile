import 'package:smartsfv/models/Article.dart';
import 'package:smartsfv/models/Depot.dart';

class MouvStockArticle {
  // todo: Properties
  static MouvStockArticle? mouvement;
  int id;
  Article article;
  Depot depot;
  int qteInit;
  int qteApprox;
  int qteDestock;
  int qteTransf;
  int qteVendue;
  // todo: Constructor
  MouvStockArticle({
    this.id = 0,
    required this.article,
    required this.depot,
    this.qteInit = 0,
    this.qteApprox = 0,
    this.qteDestock = 0,
    this.qteTransf = 0,
    this.qteVendue = 0,
  });
  // todo: Methods
  // get data from json method
  factory MouvStockArticle.fromJson(Map<String, dynamic> json) {
    return MouvStockArticle(
      id: (json['id'] != null) ? json['id'] as int : 0,
      article: (json['article'] != null)
          ? Article.fromJson(json['article'])
          : Article.fromJson({}),
      depot: (json['depot'] != null)
          ? Depot.fromJson(json['depot'])
          : Depot.fromJson({}),
      qteInit: (json['quantite_initiale'] != null)
          ? json['quantite_initiale'] as int
          : 0,
      qteApprox:
          (json['quantite_appro'] != null) ? json['quantite_appro'] as int : 0,
      qteTransf: (json['quantite_transf'] != null)
          ? json['quantite_transf'] as int
          : 0,
      qteDestock: (json['quantite_destock'] != null)
          ? json['quantite_destock'] as int
          : 0,
      qteVendue: (json['quantite_vendue'] != null)
          ? json['quantite_vendue'] as int
          : 0,
    );
  }
  // get data from instance method
  factory MouvStockArticle.fromInstance(MouvStockArticle mouvement) {
    return MouvStockArticle(
      id: mouvement.id,
      article: mouvement.article,
      depot: mouvement.depot,
      qteInit: mouvement.qteInit,
      qteApprox: mouvement.qteApprox,
      qteDestock: mouvement.qteDestock,
      qteTransf: mouvement.qteTransf,
      qteVendue: mouvement.qteVendue,
    );
  }
}
