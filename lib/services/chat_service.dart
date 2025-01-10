// lib/services/chat_service.dart

import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/chat_message.dart';
import '../models/chat_conversation.dart';

class ChatService extends ChangeNotifier {
  final Map<String, ChatConversation> _conversations = {};
  Timer? _simulatedResponseTimer;

  ChatConversation? getConversation(String orderId) {
    return _conversations[orderId];
  }

  List<ChatMessage> getMessages(String orderId) {
    return _conversations[orderId]?.messages ?? [];
  }

  Future<void> initializeChat(String orderId, String driverId) async {
    if (_conversations.containsKey(orderId)) return;

    _conversations[orderId] = ChatConversation(
      orderId: orderId,
      driverId: driverId,
      messages: [
        ChatMessage(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          content: 'Olá! Estou a caminho do restaurante para buscar seu pedido.',
          timestamp: DateTime.now(),
          sender: MessageSender.driver,
          isRead: false,
        ),
      ],
      lastMessageTime: DateTime.now(),
    );
    notifyListeners();
  }

  Future<void> sendMessage(String orderId, String content) async {
    if (!_conversations.containsKey(orderId)) return;

    final message = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: content,
      timestamp: DateTime.now(),
      sender: MessageSender.user,
    );

    final conversation = _conversations[orderId]!;
    final updatedMessages = [...conversation.messages, message];

    _conversations[orderId] = ChatConversation(
      orderId: orderId,
      driverId: conversation.driverId,
      messages: updatedMessages,
      lastMessageTime: DateTime.now(),
    );

    notifyListeners();

    // Simular resposta do entregador
    _simulateDriverResponse(orderId);
  }

  void _simulateDriverResponse(String orderId) {
    _simulatedResponseTimer?.cancel();
    _simulatedResponseTimer = Timer(const Duration(seconds: 2), () {
      if (!_conversations.containsKey(orderId)) return;

      final driverMessage = ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        content: _getRandomDriverResponse(),
        timestamp: DateTime.now(),
        sender: MessageSender.driver,
      );

      final conversation = _conversations[orderId]!;
      final updatedMessages = [...conversation.messages, driverMessage];

      _conversations[orderId] = ChatConversation(
        orderId: orderId,
        driverId: conversation.driverId,
        messages: updatedMessages,
        lastMessageTime: DateTime.now(),
        hasUnreadMessages: true,
      );

      notifyListeners();
    });
  }

  String _getRandomDriverResponse() {
    final responses = [
      'Estou a caminho!',
      'Chegarei em aproximadamente 10 minutos.',
      'Já estou próximo ao seu endereço.',
      'O trânsito está um pouco lento, mas já estou chegando.',
      'Pode deixar que já estou indo.',
    ];
    return responses[DateTime.now().second % responses.length];
  }

  void markMessagesAsRead(String orderId) {
    if (!_conversations.containsKey(orderId)) return;

    final conversation = _conversations[orderId]!;
    final updatedMessages = conversation.messages.map((message) {
      if (message.sender == MessageSender.driver && !message.isRead) {
        return ChatMessage(
          id: message.id,
          content: message.content,
          timestamp: message.timestamp,
          sender: message.sender,
          isRead: true,
          imageUrl: message.imageUrl,
        );
      }
      return message;
    }).toList();

    _conversations[orderId] = ChatConversation(
      orderId: orderId,
      driverId: conversation.driverId,
      messages: updatedMessages,
      lastMessageTime: conversation.lastMessageTime,
      hasUnreadMessages: false,
    );

    notifyListeners();
  }

  @override
  void dispose() {
    _simulatedResponseTimer?.cancel();
    super.dispose();
  }
}