// lib/models/chat_message.dart

enum MessageSender {
  user,
  driver
}

class ChatMessage {
  final String id;
  final String content;
  final DateTime timestamp;
  final MessageSender sender;
  final bool isRead;
  final String? imageUrl;

  ChatMessage({
    required this.id,
    required this.content,
    required this.timestamp,
    required this.sender,
    this.isRead = false,
    this.imageUrl,
  });

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      id: map['id'] as String,
      content: map['content'] as String,
      timestamp: DateTime.parse(map['timestamp'] as String),
      sender: MessageSender.values.byName(map['sender']),
      isRead: map['isRead'] as bool? ?? false,
      imageUrl: map['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
      'sender': sender.name,
      'isRead': isRead,
      'imageUrl': imageUrl,
    };
  }
}

// lib/models/chat_conversation.dart
class ChatConversation {
  final String orderId;
  final String driverId;
  final List<ChatMessage> messages;
  final DateTime lastMessageTime;
  final bool hasUnreadMessages;

  ChatConversation({
    required this.orderId,
    required this.driverId,
    required this.messages,
    required this.lastMessageTime,
    this.hasUnreadMessages = false,
  });
}