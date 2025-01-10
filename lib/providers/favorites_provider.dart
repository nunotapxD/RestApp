// lib/providers/favorites_provider.dart

import 'package:flutter/foundation.dart';
import '../models/restaurant.dart';

class FavoritesProvider extends ChangeNotifier {
  final Set<Restaurant> _favoriteRestaurants = {};

  List<Restaurant> get favoriteRestaurants => _favoriteRestaurants.toList();
  
  bool isRestaurantFavorite(String id) {
    return _favoriteRestaurants.any((restaurant) => restaurant.id == id);
  }

  void toggleFavorite(Restaurant restaurant) {
    if (isRestaurantFavorite(restaurant.id)) {
      _favoriteRestaurants.removeWhere((r) => r.id == restaurant.id);
    } else {
      _favoriteRestaurants.add(restaurant);
    }
    notifyListeners();
  }
}