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
  double _deliveryFee = 5.0;
  double _discount = 0.0;
  String? _couponCode;

  Map<String, CartItem> get items => {..._items};
  
  int get itemCount {
    return _items.values.fold(0, (sum, item) => sum + item.quantity);
  }
  
  double get subtotal {
    return _items.values.fold(0.0, (sum, item) => sum + item.total);
  }

  double get deliveryFee {
    if (subtotal >= 50) return 0; // Entrega grátis acima de €50
    return _deliveryFee;
  }

  double get discount => _discount;
  String? get couponCode => _couponCode;
  
  double get total => subtotal + deliveryFee - discount;
  
  bool get isEmpty => _items.isEmpty;

  void addToCart(Dish dish) {
    if (_items.containsKey(dish.id)) {
      // Atualiza a quantidade se o item já existe
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
      _items.update(
        dish.id,
        (existingItem) => CartItem(
          dish: existingItem.dish,
          quantity: existingItem.quantity - 1,
          price: existingItem.price,
        ),
      );
    } else {
      _items.remove(dish.id);
    }
    notifyListeners();
  }

  void applyCoupon(String code, double discountValue) {
    _couponCode = code;
    _discount = discountValue;
    notifyListeners();
  }

  void removeCoupon() {
    _couponCode = null;
    _discount = 0;
    notifyListeners();
  }

  void clear() {
    _items.clear();
    _couponCode = null;
    _discount = 0;
    notifyListeners();
  }
}