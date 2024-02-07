class CategoryEntity {
  CategoryEntity({
    required this.categories,
  });

  List<Category> categories;

  factory CategoryEntity.fromJson(Map<String, dynamic> json) => CategoryEntity(
        categories: List<Category>.from(
            json["Categories"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Categories": List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}

class Category {
  Category({
    required this.id,
    this.image,
    required this.name,
    this.slug,
  });

  int id;
  String? image;
  String name;
  String? slug;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        image: json["icon"],
        name: json["name"],
        slug: json["slug"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "slug": slug,
      };
}
