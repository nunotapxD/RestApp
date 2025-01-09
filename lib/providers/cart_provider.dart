// lib/providers/cart_provider.dart

import 'package:flutter/foundation.dart';
import '../models/dish.dart';

class CartItem {
  final Dish dish;
  int quantity;
  final double price;

  CartItem({
    required this.dish,
    this.quantity = 1,
    required this.price,
  });

  double get total => price * quantity;
}

class CartProvider extends ChangeNotifier {
  final Map<String, CartItem> _items = {};
  
  Map<String, CartItem> get items => {..._items};
  
  int get itemCount {
    return _items.values.fold(0, (sum, item) => sum + item.quantity);
  }
  
  double get total {
    return _items.values.fold(0.0, (sum, item) => sum + item.total);
  }
  
  bool get isEmpty => _items.isEmpty;

  void addToCart(Dish dish) {
    if (_items.containsKey(dish.id)) {
      // Aumenta a quantidade se o item já existe
      _items.update(
        dish.id,
        (existingItem) => CartItem(
          dish: existingItem.dish,
          quantity: existingItem.quantity + 1,
          price: existingItem.price,
        ),
      );
    } else {
      // Adiciona novo item
      _items.putIfAbsent(
        dish.id,
        () => CartItem(
          dish: dish,
          quantity: 1,
          price: dish.price,
        ),
      );
    }
    notifyListeners();
  }

  void removeFromCart(Dish dish) {
    if (!_items.containsKey(dish.id)) return;

    if (_items[dish.id]!.quantity > 1) {
      // Diminui a quantidade se tiver mais de um
      _items.update(
        dish.id,
        (existingItem) => CartItem(
          dish: existingItem.dish,
          quantity: existingItem.quantity - 1,
          price: existingItem.price,
        ),
      );
    } else {
      // Remove o item se só tiver um
      _items.remove(dish.id);
    }
    notifyListeners();
  }

  void updateQuantity(String dishId, int quantity) {
    if (!_items.containsKey(dishId)) return;
    
    if (quantity <= 0) {
      _items.remove(dishId);
    } else {
      _items.update(
        dishId,
        (existingItem) => CartItem(
          dish: existingItem.dish,
          quantity: quantity,
          price: existingItem.price,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String dishId) {
    _items.remove(dishId);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  int getQuantity(String dishId) {
    return _items[dishId]?.quantity ?? 0;
  }

  bool hasItem(String dishId) {
    return _items.containsKey(dishId);
  }

  CartItem? getItem(String dishId) {
    return _items[dishId];
  }

  // Método para aplicar cupom de desconto
  double applyDiscount(String couponCode) {
    // Implementar lógica de desconto aqui
    // Por exemplo:
    switch (couponCode) {
      case 'PRIMEIRO10':
        return total * 0.9; // 10% de desconto
      case 'FRETE':
        return total - 10; // €10 de desconto
      default:
        return total;
    }
  }

  // Método para verificar se pode aplicar frete grátis
  bool canApplyFreeDelivery() {
    return total >= 50; // Frete grátis para compras acima de €50
  }

  // Método para calcular frete
  double calculateDeliveryFee(double distance) {
    if (canApplyFreeDelivery()) return 0;
    
    // Base de €5 + €2 por km
    return 5 + (distance * 2);
  }

  // Método para obter resumo do pedido
  Map<String, double> getOrderSummary({
    String? couponCode,
    double distance = 0,
  }) {
    double subtotal = total;
    double discount = couponCode != null ? total - applyDiscount(couponCode) : 0;
    double deliveryFee = calculateDeliveryFee(distance);
    double finalTotal = subtotal - discount + deliveryFee;

    return {
      'subtotal': subtotal,
      'discount': discount,
      'deliveryFee': deliveryFee,
      'total': finalTotal,
    };
  }
}