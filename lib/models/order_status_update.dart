// lib/models/order_status_update.dart

import 'order_status.dart';

class OrderStatusUpdate {
  final OrderStatus status;
  final DateTime timestamp;
  final String message;

  const OrderStatusUpdate({
    required this.status,
    required this.timestamp,
    required this.message,
  });

  factory OrderStatusUpdate.fromMap(Map<String, dynamic> map) {
    return OrderStatusUpdate(
      status: OrderStatus.values.byName(map['status'] as String),
      timestamp: DateTime.parse(map['timestamp'] as String),
      message: map['message'] as String,
    );
  }

  Map<String, String> toMap() => {
    'status': status.name,
    'timestamp': timestamp.toIso8601String(),
    'message': message,
  };

  static String getDefaultMessage(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return 'Pedido recebido';
      case OrderStatus.confirmed:
        return 'Pedido confirmado pelo restaurante';
      case OrderStatus.preparing:
        return 'Seu pedido está sendo preparado';
      case OrderStatus.readyForPickup:
        return 'Pedido pronto para retirada';
      case OrderStatus.pickedUp:
        return 'Entregador retirou seu pedido';
      case OrderStatus.onTheWay:
        return 'Entregador a caminho';
      case OrderStatus.delivered:
        return 'Pedido entregue';
      case OrderStatus.cancelled:
        return 'Pedido cancelado';
    }
  }
}