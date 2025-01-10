
class Coupon {
  final String code;
  final double discountPercentage;
  final double? maxDiscount;
  final DateTime expirationDate;
  final double? minOrderValue;
  final bool isActive;

  Coupon({
    required this.code,
    required this.discountPercentage,
    this.maxDiscount,
    required this.expirationDate,
    this.minOrderValue,
    this.isActive = true,
  });

  double calculateDiscount(double orderValue) {
    if (!isActive || DateTime.now().isAfter(expirationDate)) return 0;
    if (minOrderValue != null && orderValue < minOrderValue!) return 0;
    
    double discount = orderValue * (discountPercentage / 100);
    if (maxDiscount != null && discount > maxDiscount!) {
      return maxDiscount!;
    }
    return discount;
  }
}

class CouponService {
  final Map<String, Coupon> _coupons = {
    'PRIMEIRO10': Coupon(
      code: 'PRIMEIRO10',
      discountPercentage: 10,
      maxDiscount: 20,
      expirationDate: DateTime.now().add(const Duration(days: 30)),
      minOrderValue: 20,
    ),
    'FRETE': Coupon(
      code: 'FRETE',
      discountPercentage: 100,
      maxDiscount: 10,
      expirationDate: DateTime.now().add(const Duration(days: 7)),
      minOrderValue: 50,
    ),
  };

  Coupon? validateCoupon(String code) {
    final coupon = _coupons[code.toUpperCase()];
    if (coupon == null) return null;
    if (!coupon.isActive) return null;
    if (DateTime.now().isAfter(coupon.expirationDate)) return null;
    return coupon;
  }

  double calculateDiscount(String code, double orderValue) {
    final coupon = validateCoupon(code);
    if (coupon == null) return 0;
    return coupon.calculateDiscount(orderValue);
  }
}