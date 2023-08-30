class CategoryModel {
  String id;
  String name;
  String image;
  String status;
  String? imageUrl;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.status,
    this.imageUrl,
  });

  String categoryAsName() {
    return name;
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        status: json["status"],
        imageUrl: json["imageUrl"]);
  }
}
