class Category {
  // todo: Properties
  int id;
  String libelle;
  // todo: Constructor
  Category({
    this.id = 0,
    this.libelle = '',
  });
  // todo: Methods
  // get data from json method
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as int,
      libelle: json['libelle_category'] as String,
    );
  }
}
