import 'package:flutter/foundation.dart';

class SessionProvider extends ChangeNotifier {
  String? _userName;
  List<CreditCard> _savedCards = [];
  
  String get userName => _userName ?? 'Usuário';
  List<CreditCard> get savedCards => List.unmodifiable(_savedCards);

  void updateUserName(String name) {
    _userName = name;
    notifyListeners();
  }

  void addCreditCard(CreditCard card) {
    _savedCards.add(card);
    notifyListeners();
  }

  void removeCreditCard(String cardId) {
    _savedCards.removeWhere((card) => card.id == cardId);
    notifyListeners();
  }

  void setDefaultCard(String cardId) {
    _savedCards = _savedCards.map((card) {
      return CreditCard(
        id: card.id,
        number: card.number,
        holderName: card.holderName,
        expiryDate: card.expiryDate,
        isDefault: card.id == cardId,
      );
    }).toList();
    notifyListeners();
  }
}

class CreditCard {
  final String id;
  final String number;
  final String holderName;
  final String expiryDate;
  final bool isDefault;

  CreditCard({
    required this.id,
    required this.number,
    required this.holderName,
    required this.expiryDate,
    this.isDefault = false,
  });

  String get maskedNumber => '**** **** **** ${number.substring(number.length - 4)}';
}