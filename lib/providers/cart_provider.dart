// lib/providers/cart_provider.dart

import 'package:flutter/foundation.dart';
import '../models/dish.dart';
import '../services/coupon_service.dart';
import '../services/auth_service.dart';

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
  final CouponService _couponService = CouponService();
  final AuthService _authService = AuthService();
  String? _appliedCouponCode;
  bool _requiresBiometrics = false;

  Map<String, CartItem> get items => {..._items};
  String? get appliedCouponCode => _appliedCouponCode;
  
  int get itemCount {
    return _items.values.fold(0, (sum, item) => sum + item.quantity);
  }
  
  double get subtotal {
    return _items.values.fold(0.0, (sum, item) => sum + item.total);
  }

  double get discount {
    if (_appliedCouponCode == null) return 0;
    return _couponService.calculateDiscount(_appliedCouponCode!, subtotal);
  }

  double get deliveryFee {
    if (subtotal >= 50) return 0; // Free delivery over €50
    return 5.0; // Base delivery fee
  }
  
  double get total {
    return subtotal - discount + deliveryFee;
  }
  
  bool get isEmpty => _items.isEmpty;

  Future<bool> applyCoupon(String code) async {
    final coupon = _couponService.validateCoupon(code);
    if (coupon == null) return false;
    
    _appliedCouponCode = code;
    notifyListeners();
    return true;
  }

  void removeCoupon() {
    _appliedCouponCode = null;
    notifyListeners();
  }

  Future<bool> requiresBiometricAuth() async {
    if (!_requiresBiometrics) return false;
    return await _authService.isBiometricsAvailable();
  }

  Future<bool> authenticateForPayment() async {
    if (!_requiresBiometrics) return true;
    return await _authService.authenticateWithBiometrics();
  }

  void setRequiresBiometrics(bool value) {
    _requiresBiometrics = value;
    notifyListeners();
  }

  Future<Map<String, dynamic>> getOrderSummary() async {
    bool canUseBiometrics = await requiresBiometricAuth();
    
    return {
      'subtotal': subtotal,
      'discount': discount,
      'deliveryFee': deliveryFee,
      'total': total,
      'appliedCoupon': _appliedCouponCode,
      'itemCount': itemCount,
      'canUseBiometrics': canUseBiometrics,
    };
  }

  void addToCart(Dish dish) {
    if (_items.containsKey(dish.id)) {
      _items.update(
        dish.id,
        (existingItem) => CartItem(
          dish: existingItem.dish,
          quantity: existingItem.quantity + 1,
          price: existingItem.price,
        ),
      );
    } else {
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

  void clear() {
    _items.clear();
    _appliedCouponCode = null;
    notifyListeners();
  }
}