class SubCategory {
  // todo: Properties
  int id;
  String libelle;
  // todo: Constructor
  SubCategory({
    this.id = 0,
    this.libelle = '',
  });
  // todo: Methods
  // get data from json method
  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'] as int,
      libelle: json['libelle_subcategory'] as String,
    );
  }
}
