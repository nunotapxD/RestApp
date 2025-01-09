class Dish {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final bool isPopular;
  final bool isSpicy;

  Dish({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isPopular = false,
    this.isSpicy = false,
  });
}