// lib/services/restaurant_service.dart

import '../models/restaurant.dart';
import '../models/dish.dart';

Future<Restaurant> fetchRestaurantById(String id) async {
  // Simula uma chamada de API
  await Future.delayed(const Duration(seconds: 1));
  
  return Restaurant(
    id: id,
    name: 'Mister Churrasco',
    imageUrl: 'assets/images/restaurants/restaurant1.jpg',
    rating: 4.5,
    reviewCount: 150,
    deliveryTime: '30-45 min',
    distance: '1.2 km',
    priceLevel: '\$\$',
    cuisine: 'Brasileira',
    isOpen: true,
    openingHours: '11:00 - 23:00',
    featuredDishes: [], // Adicione pratos de exemplo aqui
    mainDishes: [],    // Adicione pratos principais aqui
    drinks: [],        // Adicione bebidas aqui
    desserts: [],      // Adicione sobremesas aqui
  );
}