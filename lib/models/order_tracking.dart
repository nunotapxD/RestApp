// lib/models/order_tracking.dart

import 'order_status.dart';
import 'delivery_driver.dart';
import 'delivery_location.dart';
import 'order_status_update.dart';

class OrderTracking {
  final String orderId;
  final OrderStatus status;
  final DeliveryDriver? driver;
  final DeliveryLocation? driverLocation;
  final DateTime estimatedDeliveryTime;
  final List<OrderStatusUpdate> statusUpdates;
  final String restaurantName;
  final String restaurantAddress;
  final String deliveryAddress;
  final bool isLive;

  const OrderTracking({
    required this.orderId,
    required this.status,
    this.driver,
    this.driverLocation,
    required this.estimatedDeliveryTime,
    required this.statusUpdates,
    required this.restaurantName,
    required this.restaurantAddress,
    required this.deliveryAddress,
    this.isLive = true,
  });

  factory OrderTracking.fromMockData() {
    return OrderTracking(
      orderId: 'ORDER-${DateTime.now().millisecondsSinceEpoch}',
      status: OrderStatus.onTheWay,
      driver: DeliveryDriver(
        id: 'D001',
        name: 'João Silva',
        photoUrl: 'assets/images/driver.jpg',
        phone: '+351 912 345 678',
        rating: 4.8,
        totalDeliveries: 1234,
        vehicleType: 'Moto',
        vehiclePlate: '12-AB-34',
      ),
      driverLocation: DeliveryLocation(
        latitude: -23.550520,
        longitude: -46.633308,
        timestamp: DateTime.now(),
        heading: 45,
        speed: 30,
      ),
      estimatedDeliveryTime: DateTime.now().add(const Duration(minutes: 30)),
      statusUpdates: _getMockStatusUpdates(),
      restaurantName: 'Restaurante Exemplo',
      restaurantAddress: 'Rua Exemplo, 123',
      deliveryAddress: 'Av. Cliente, 456',
    );
  }

  static List<OrderStatusUpdate> _getMockStatusUpdates() {
    final now = DateTime.now();
    return [
      OrderStatusUpdate(
        status: OrderStatus.pending,
        timestamp: now.subtract(const Duration(minutes: 30)),
        message: OrderStatus.getDefaultMessage(OrderStatus.pending),
      ),
      OrderStatusUpdate(
        status: OrderStatus.confirmed,
        timestamp: now.subtract(const Duration(minutes: 25)),
        message: OrderStatus.getDefaultMessage(OrderStatus.confirmed),
      ),
      OrderStatusUpdate(
        status: OrderStatus.preparing,
        timestamp: now.subtract(const Duration(minutes: 20)),
        message: OrderStatus.getDefaultMessage(OrderStatus.preparing),
      ),
      OrderStatusUpdate(
        status: OrderStatus.readyForPickup,
        timestamp: now.subtract(const Duration(minutes: 15)),
        message: OrderStatus.getDefaultMessage(OrderStatus.readyForPickup),
      ),
      OrderStatusUpdate(
        status: OrderStatus.onTheWay,
        timestamp: now.subtract(const Duration(minutes: 5)),
        message: OrderStatus.getDefaultMessage(OrderStatus.onTheWay),
      ),
    ];
  }

  /// Retorna o tempo restante estimado em minutos
  int get remainingTime {
    final remaining = estimatedDeliveryTime.difference(DateTime.now());
    return remaining.inMinutes;
  }

  /// Retorna a última atualização de status
  OrderStatusUpdate? get lastUpdate =>
      statusUpdates.isNotEmpty ? statusUpdates.last : null;
      
  /// Retorna a porcentagem de progresso (0-100)
  double get progress {
    const statusWeight = {
      OrderStatus.pending: 0.0,
      OrderStatus.confirmed: 0.2,
      OrderStatus.preparing: 0.4,
      OrderStatus.readyForPickup: 0.6,
      OrderStatus.pickedUp: 0.7,
      OrderStatus.onTheWay: 0.8,
      OrderStatus.delivered: 1.0,
      OrderStatus.cancelled: 0.0,
    };
    
    return (statusWeight[status] ?? 0.0) * 100;
  }

  /// Retorna uma versão mockada com o status atualizado
  OrderTracking updateStatus(OrderStatus newStatus) {
    final newUpdates = [...statusUpdates];
    newUpdates.add(
      OrderStatusUpdate(
        status: newStatus,
        timestamp: DateTime.now(),
        message: OrderStatus.getDefaultMessage(newStatus),
      ),
    );

    return OrderTracking(
      orderId: orderId,
      status: newStatus,
      driver: driver,
      driverLocation: driverLocation,
      estimatedDeliveryTime: estimatedDeliveryTime,
      statusUpdates: newUpdates,
      restaurantName: restaurantName,
      restaurantAddress: restaurantAddress,
      deliveryAddress: deliveryAddress,
      isLive: isLive,
    );
  }

  /// Simula uma atualização da localização do entregador
  OrderTracking updateDriverLocation(DeliveryLocation newLocation) {
    return OrderTracking(
      orderId: orderId,
      status: status,
      driver: driver,
      driverLocation: newLocation,
      estimatedDeliveryTime: estimatedDeliveryTime,
      statusUpdates: statusUpdates,
      restaurantName: restaurantName,
      restaurantAddress: restaurantAddress,
      deliveryAddress: deliveryAddress,
      isLive: isLive,
    );
  }
}