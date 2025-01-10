// lib/services/tracking_service.dart

import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/order_status.dart';
import '../models/delivery_driver.dart';
import '../models/delivery_location.dart';
import '../models/order_tracking.dart';
import '../models/order_status_update.dart';

class TrackingService extends ChangeNotifier {
  final Map<String, OrderTracking> _activeOrders = {};
  Timer? _locationUpdateTimer;
  final _mockDriverLocations = [
    DeliveryLocation(
      latitude: 41.1579,
      longitude: -8.6291,
      timestamp: DateTime.now(),
      heading: 45,
    ),
    DeliveryLocation(
      latitude: 41.1589,
      longitude: -8.6281,
      timestamp: DateTime.now(),
      heading: 45,
    ),
    DeliveryLocation(
      latitude: 41.1599,
      longitude: -8.6271,
      timestamp: DateTime.now(),
      heading: 45,
    ),
  ];
  int _mockLocationIndex = 0;

  Map<String, OrderTracking> get activeOrders => {..._activeOrders};

  TrackingService() {
    _startLocationUpdates();
  }

  void _startLocationUpdates() {
    _locationUpdateTimer?.cancel();
    _locationUpdateTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _updateDriverLocations();
    });
  }

  void _updateDriverLocations() {
    if (_activeOrders.isEmpty) return;

    for (var orderId in _activeOrders.keys) {
      final order = _activeOrders[orderId];
      if (order != null && 
          order.status == OrderStatus.onTheWay && 
          order.isLive) {
        _mockLocationIndex = (_mockLocationIndex + 1) % _mockDriverLocations.length;
        final newLocation = _mockDriverLocations[_mockLocationIndex];
        
        _activeOrders[orderId] = OrderTracking(
          orderId: order.orderId,
          status: order.status,
          driver: order.driver,
          driverLocation: newLocation,
          estimatedDeliveryTime: order.estimatedDeliveryTime,
          statusUpdates: order.statusUpdates,
          restaurantName: order.restaurantName,
          restaurantAddress: order.restaurantAddress,
          deliveryAddress: order.deliveryAddress,
        );
        
        notifyListeners();
      }
    }
  }

  Future<void> startTracking(String orderId) async {
    if (_activeOrders.containsKey(orderId)) return;

    final mockDriver = DeliveryDriver(
      id: 'D001',
      name: 'João Silva',
      photoUrl: 'assets/images/driver.jpg',
      phone: '+351 912 345 678',
      rating: 4.8,
      totalDeliveries: 1234,
      vehicleType: 'Moto',
      vehiclePlate: '12-AB-34',
    );

    final initialLocation = _mockDriverLocations[0];
    final now = DateTime.now();

    final tracking = OrderTracking(
      orderId: orderId,
      status: OrderStatus.confirmed,
      driver: mockDriver,
      driverLocation: initialLocation,
      estimatedDeliveryTime: now.add(const Duration(minutes: 45)),
      statusUpdates: [
        OrderStatusUpdate(
          status: OrderStatus.pending,
          timestamp: now.subtract(const Duration(minutes: 5)),
          message: OrderStatusUpdate.getDefaultMessage(OrderStatus.pending),
        ),
        OrderStatusUpdate(
          status: OrderStatus.confirmed,
          timestamp: now,
          message: OrderStatusUpdate.getDefaultMessage(OrderStatus.confirmed),
        ),
      ],
      restaurantName: 'Mister Churrasco',
      restaurantAddress: 'Rua da Maia, 123',
      deliveryAddress: 'Avenida dos Aliados, 45',
    );

    _activeOrders[orderId] = tracking;
    notifyListeners();
  }

  Future<void> updateOrderStatus(String orderId, OrderStatus newStatus) async {
    if (!_activeOrders.containsKey(orderId)) return;

    final order = _activeOrders[orderId]!;
    final updates = [...order.statusUpdates];
    updates.add(OrderStatusUpdate(
      status: newStatus,
      timestamp: DateTime.now(),
      message: OrderStatusUpdate.getDefaultMessage(newStatus),
    ));

    _activeOrders[orderId] = OrderTracking(
      orderId: order.orderId,
      status: newStatus,
      driver: order.driver,
      driverLocation: order.driverLocation,
      estimatedDeliveryTime: order.estimatedDeliveryTime,
      statusUpdates: updates,
      restaurantName: order.restaurantName,
      restaurantAddress: order.restaurantAddress,
      deliveryAddress: order.deliveryAddress,
    );

    notifyListeners();
  }

  Future<void> stopTracking(String orderId) async {
    _activeOrders.remove(orderId);
    notifyListeners();
  }

  @override
  void dispose() {
    _locationUpdateTimer?.cancel();
    super.dispose();
  }
}