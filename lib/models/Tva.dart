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
      percent: json['libelle_tva'] as double,
    );
  }
}
