class Tva {
  // todo: Properties
  int id;
  double percent;
  // todo: Constructor
  Tva({
    this.id = 0,
    this.percent = 0,
  });
  // todo: Methods
  // get data from json method
  factory Tva.fromJson(Map<String, dynamic> json) {
    return Tva(
      id: json['id'] as int,
      percent: double.parse(json['montant_tva'].toString()),
    );
  }
  // return to Map
  static Map<String, dynamic> toMap(Tva tva) {
    return <String, dynamic>{
      //'id': tva.id,
      'montant_tva': tva.percent.toInt(),
    };
  }
}
