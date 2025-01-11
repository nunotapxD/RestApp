// user_settings_provider.dart
import 'package:flutter/foundation.dart';

class Address {
  final String id;
  final String name;
  final String street;
  final String number;
  final String complement;
  final String city;
  final bool isDefault;

  Address({
    required this.id,
    required this.name,
    required this.street,
    required this.number,
    this.complement = '',
    required this.city,
    this.isDefault = false,
  });
}

class NotificationSettings {
  bool orders;
  bool promotions;
  bool news;

  NotificationSettings({
    this.orders = true,
    this.promotions = true,
    this.news = true,
  });
}

class UserSettingsProvider extends ChangeNotifier {
  List<Address> _addresses = [];
  NotificationSettings _notifications = NotificationSettings();

  // Getters
  List<Address> get addresses => List.unmodifiable(_addresses);
  NotificationSettings get notifications => _notifications;
  Address? get defaultAddress => _addresses.cast<Address?>().firstWhere(
        (address) => address?.isDefault ?? false,
        orElse: () => null,
      );

  // Constructor com dados iniciais de exemplo
  UserSettingsProvider() {
    _addresses = [
      Address(
        id: '1',
        name: 'Casa',
        street: 'Rua da Maia',
        number: '123',
        city: 'Porto',
        isDefault: true,
      ),
      Address(
        id: '2',
        name: 'Trabalho',
        street: 'Avenida dos Aliados',
        number: '45',
        city: 'Porto',
      ),
    ];
  }

  // Métodos para gerenciar endereços
  void addAddress(Address address) {
    if (address.isDefault) {
      _addresses = _addresses.map((a) => Address(
        id: a.id,
        name: a.name,
        street: a.street,
        number: a.number,
        complement: a.complement,
        city: a.city,
        isDefault: false,
      )).toList();
    }
    _addresses.add(address);
    notifyListeners();
  }

  void updateAddress(Address address) {
    final index = _addresses.indexWhere((a) => a.id == address.id);
    if (index != -1) {
      if (address.isDefault) {
        _addresses = _addresses.map((a) => Address(
          id: a.id,
          name: a.name,
          street: a.street,
          number: a.number,
          complement: a.complement,
          city: a.city,
          isDefault: a.id == address.id,
        )).toList();
      } else {
        _addresses[index] = address;
      }
      notifyListeners();
    }
  }

  void removeAddress(String id) {
    _addresses.removeWhere((a) => a.id == id);
    notifyListeners();
  }

  void setDefaultAddress(String id) {
    _addresses = _addresses.map((a) => Address(
      id: a.id,
      name: a.name,
      street: a.street,
      number: a.number,
      complement: a.complement,
      city: a.city,
      isDefault: a.id == id,
    )).toList();
    notifyListeners();
  }

  // Métodos para gerenciar notificações
  void toggleOrderNotifications(bool value) {
    _notifications.orders = value;
    notifyListeners();
  }

  void togglePromotionNotifications(bool value) {
    _notifications.promotions = value;
    notifyListeners();
  }

  void toggleNewsNotifications(bool value) {
    _notifications.news = value;
    notifyListeners();
  }
}