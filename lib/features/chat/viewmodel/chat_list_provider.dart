import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConversationItem {
  final String id;
  final String name;
  final String lastMessage;
  final DateTime updatedAt;
  final int unreadCount;

  const ConversationItem({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.updatedAt,
    this.unreadCount = 0,
  });
}

final chatListProvider = Provider<List<ConversationItem>>((ref) {
  return [
    ConversationItem(
      id: "general",
      name: "General Chat",
      lastMessage: "Welcome to the general room 👋",
      updatedAt: DateTime(2026, 2, 7, 8, 30),
      unreadCount: 2,
    ),
    ConversationItem(
      id: "support",
      name: "Support",
      lastMessage: "How can we help you today?",
      updatedAt: DateTime(2026, 2, 7, 7, 50),
      unreadCount: 0,
    ),
  ];
});