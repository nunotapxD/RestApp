class DeliveryLocation {
  final double latitude;
  final double longitude;
  final DateTime timestamp;
  final double heading;
  final double speed;

  DeliveryLocation({
    required this.latitude,
    required this.longitude,
    required this.timestamp,
    required this.heading,
    this.speed = 0,
  });
}