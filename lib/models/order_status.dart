// lib/models/order_status.dart

enum OrderStatus {
  pending,
  confirmed,
  preparing,
  readyForPickup,
  pickedUp,
  onTheWay,
  delivered,
  cancelled;
  
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