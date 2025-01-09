import 'dish.dart';

class Restaurant {
  final String id;
  final String name;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final String deliveryTime;
  final String distance;
  final String priceLevel;
  final String cuisine;
  final bool isOpen;
  final String openingHours;
  final List<Dish> featuredDishes;
  final List<Dish> mainDishes;
  final List<Dish> drinks;
  final List<Dish> desserts;

  Restaurant({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.deliveryTime,
    required this.distance,
    required this.priceLevel,
    required this.cuisine,
    required this.isOpen,
    required this.openingHours,
    required this.featuredDishes,
    required this.mainDishes,
    required this.drinks,
    required this.desserts,
  });
}