// lib/utils/mock_status_updates.dart

import '../models/order_status.dart';
import '../models/order_status_update.dart';

class MockStatusUpdates {
  static List<OrderStatusUpdate> getMockUpdates() {
    final now = DateTime.now();
    return [
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
    ];
  }
}