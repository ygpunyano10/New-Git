class CarModel {
  final String id;
  final String name;
  final String category;
  final String description;
  final String price;
  final String image;
  final String? imageUrl;

  CarModel({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.image,
    this.imageUrl,
  });
}
